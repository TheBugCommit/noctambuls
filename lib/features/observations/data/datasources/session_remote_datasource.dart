import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:noctambuls/features/observations/data/models/api/session_history_response_model.dart';
import 'package:noctambuls/features/observations/data/models/api/sync_request_model.dart';
import 'package:noctambuls/features/observations/data/models/api/sync_response_model.dart';

abstract class SessionRemoteDataSource {
  Future<SyncResponseModel> syncSessions(SyncRequestModel request);

  Future<SessionHistoryResponseModel> fetchHistory({
    required int offset,
    required int limit,
    String? since,
  });

  Future<SessionHistoryResponseModel> fetchParticipatedSessions({
    required int offset,
    required int limit,
    String? since,
  });
}

class SessionRemoteDataSourceImpl implements SessionRemoteDataSource {
  const SessionRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<SyncResponseModel> syncSessions(SyncRequestModel request) async {
    final requestData = await Isolate.run(() => request.toJson());
    final response = await dio.post<dynamic>(
      '/api/sync/observations',
      data: requestData,
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON");
    }
    return SyncResponseModel.fromJson(data);
  }

  @override
  Future<SessionHistoryResponseModel> fetchHistory({
    required int offset,
    required int limit,
    String? since,
  }) async {
    final response = await dio.get<dynamic>(
      '/api/observations/history',
      queryParameters: {
        'offset': offset,
        'limit': limit,
        'since': ?since,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON");
    }
    return Isolate.run(() => SessionHistoryResponseModel.fromJson(data));
  }

  @override
  Future<SessionHistoryResponseModel> fetchParticipatedSessions({
    required int offset,
    required int limit,
    String? since,
  }) async {
    final response = await dio.get<dynamic>(
      '/api/sessions/participated',
      queryParameters: {
        'offset': offset,
        'limit': limit,
        'since': ?since,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON");
    }
    return Isolate.run(() => SessionHistoryResponseModel.fromJson(data));
  }
}
