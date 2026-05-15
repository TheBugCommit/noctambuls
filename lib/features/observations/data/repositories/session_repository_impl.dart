import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/observations/data/datasources/session_local_datasource.dart';
import 'package:noctambuls/features/observations/data/datasources/session_remote_datasource.dart';
import 'package:noctambuls/features/observations/data/models/api/session_history_response_model.dart';
import 'package:noctambuls/features/observations/data/models/api/sync_request_model.dart';
import 'package:noctambuls/features/observations/data/models/observation_session_model.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/entities/pagination_meta.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
import 'package:noctambuls/features/observations/domain/enums/sync_status.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

const _syncChunkSize = 50;
const _historySinceKey = 'history_since';
const _participatedSinceKey = 'participated_since';

class SessionRepositoryImpl implements SessionRepository {
  SessionRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final SessionLocalDataSource localDataSource;
  final SessionRemoteDataSource remoteDataSource;

  @override
  Future<Result<Unit>> saveSession(ObservationSession session) async {
    try {
      await localDataSource.save(
        ObservationSessionModel.fromEntity(session),
      );
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<Unit>> deleteSession(String id) async {
    try {
      await localDataSource.delete(id);
      return const Ok(Unit.instance);
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<ObservationSession?>> getSessionById(String id) async {
    try {
      final model = await localDataSource.getById(id);
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<ObservationSession?>> getSessionByCensusId(
    String censusId,
  ) async {
    try {
      final model = await localDataSource.getByCensusId(censusId);
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Stream<List<ObservationSession>> watchAllSessions() {
    return localDataSource.watchAll().map(
      (models) => models.map((m) => m.toDomain()).toList(),
    );
  }

  @override
  Future<Result<ObservationSession?>> getActiveSession() async {
    try {
      final model = await localDataSource.getActiveSession();
      return Ok(model?.toDomain());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Stream<ObservationSession?> watchActiveSession() {
    return localDataSource.watchActiveSession().map(
      (model) => model?.toDomain(),
    );
  }

  @override
  Stream<ObservationSession?> watchSessionById(String id) {
    return localDataSource
        .watchSessionById(id)
        .map((model) => model?.toDomain());
  }

  @override
  Stream<List<ObservationSession>> watchOwnSessions(String annotatorId) {
    return localDataSource
        .watchOwnSessions(annotatorId)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }

  @override
  Stream<List<ObservationSession>> watchParticipatedSessions(
    String annotatorId,
  ) {
    return localDataSource
        .watchParticipatedSessions(annotatorId)
        .map((models) => models.map((m) => m.toDomain()).toList());
  }

  @override
  Future<Result<PaginationMeta>> syncPendingSessions() async {
    try {
      final sessions = await localDataSource.getPendingSessions();
      if (sessions.isEmpty) return const Ok(PaginationMeta.empty());

      final allIds = sessions.map((s) => s.id).toList();

      await localDataSource.bulkUpdateSyncStatuses({
        for (final id in allIds) id: (SyncStatus.syncing, null),
      });

      final statusUpdates = <String, (SyncStatus, SyncErrorType?)>{};

      // Process in chunks of 50.
      for (var i = 0; i < sessions.length; i += _syncChunkSize) {
        final chunk = sessions.sublist(
          i,
          (i + _syncChunkSize).clamp(0, sessions.length),
        );

        try {
          final request = await Isolate.run(
            () => SyncRequestModel(
              sessions: chunk.map(SyncSessionDto.fromModel).toList(),
            ),
          );

          final response = await remoteDataSource.syncSessions(request);

          for (final id in response.synced) {
            statusUpdates[id] = (SyncStatus.synced, null);
          }
          for (final failed in response.failed) {
            statusUpdates[failed.sessionId] = (
              SyncStatus.error,
              _classifySyncError(failed.reason),
            );
          }
        } on DioException catch (e) {
          final isNetworkError =
              e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout ||
              e.type == DioExceptionType.connectionError;

          final status = isNetworkError ? SyncStatus.pending : SyncStatus.error;
          final errorType = isNetworkError
              ? SyncErrorType.network
              : SyncErrorType.server;

          for (final s in chunk) {
            statusUpdates.putIfAbsent(s.id, () => (status, errorType));
          }
        } on Exception {
          for (final s in chunk) {
            statusUpdates.putIfAbsent(
              s.id,
              () => (SyncStatus.error, SyncErrorType.unknown),
            );
          }
        }
      }

      if (statusUpdates.isNotEmpty) {
        await localDataSource.bulkUpdateSyncStatuses(statusUpdates);
      }

      return const Ok(PaginationMeta.empty());
    } on Exception catch (e, st) {
      return Err(const DatabaseFailure().withDebug(e, st));
    }
  }

  @override
  Future<Result<PaginationMeta>> fetchAndStoreHistory({
    int limit = 20,
    bool refresh = false,
  }) async {
    return _fetchAndStore(
      metaKey: _historySinceKey,
      limit: limit,
      refresh: refresh,
      fetcher: (offset, since) => remoteDataSource.fetchHistory(
        offset: offset,
        limit: limit,
        since: since,
      ),
    );
  }

  @override
  Future<Result<PaginationMeta>> fetchAndStoreParticipatedSessions({
    int limit = 20,
    bool refresh = false,
  }) async {
    return _fetchAndStore(
      metaKey: _participatedSinceKey,
      limit: limit,
      refresh: refresh,
      fetcher: (offset, since) => remoteDataSource.fetchParticipatedSessions(
        offset: offset,
        limit: limit,
        since: since,
      ),
    );
  }

  Future<Result<PaginationMeta>> _fetchAndStore({
    required String metaKey,
    required int limit,
    required bool refresh,
    required Future<SessionHistoryResponseModel> Function(
      int offset,
      String? since,
    )
    fetcher,
  }) async {
    try {
      final metadata = await localDataSource.getSyncMetadata(metaKey);
      final page = refresh ? 0 : metadata.currentPage;
      final offset = page * limit;

      final response = await fetcher(offset, metadata.since);

      final models = await Isolate.run(
        () => response.sessions.map((dto) => dto.toModel()).toList(),
      );

      await localDataSource.bulkUpsertSessions(models);

      final meta = PaginationMeta(
        currentPage: page,
        totalPages: response.meta.totalPages,
        totalItems: response.meta.totalItems,
        hasMore: response.meta.hasMore,
        serverTime: response.serverTime,
      );

      if (!meta.hasMore) {
        // Full sync done: store serverTime as new since, reset page to 0.
        await localDataSource.saveSyncMetadata(
          metaKey,
          since: response.serverTime,
          currentPage: 0,
        );
      } else {
        await localDataSource.saveSyncMetadata(
          metaKey,
          currentPage: page + 1,
        );
      }

      return Ok(meta);
    } on DioException catch (e, st) {
      return Err(const FetchHistoryFailure().withDebug(e, st));
    } on Exception catch (e, st) {
      return Err(const FetchHistoryFailure().withDebug(e, st));
    }
  }

  SyncErrorType _classifySyncError(String apiReason) {
    final lower = apiReason.toLowerCase();
    if (lower.contains('internal')) {
      return SyncErrorType.server;
    }
    return SyncErrorType.validation;
  }
}
