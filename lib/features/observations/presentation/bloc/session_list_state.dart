import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/error/failure.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class SessionListState extends Equatable {
  const SessionListState();

  @override
  List<Object?> get props => [];
}

final class SessionListInitial extends SessionListState {
  const SessionListInitial();
}

final class SessionListData extends SessionListState {
  const SessionListData({
    this.ownSessions = const [],
    this.participatedSessions = const [],
    this.isLoadingHistory = false,
    this.isLoadingParticipated = false,
    this.isSyncing = false,
    this.hasMoreHistory = true,
    this.hasMoreParticipated = true,
    this.historyError,
    this.participatedError,
    this.syncError,
  });

  final List<ObservationSession> ownSessions;
  final List<ObservationSession> participatedSessions;
  final bool isLoadingHistory;
  final bool isLoadingParticipated;
  final bool isSyncing;
  final bool hasMoreHistory;
  final bool hasMoreParticipated;
  final Failure? historyError;
  final Failure? participatedError;
  final Failure? syncError;

  SessionListData copyWith({
    List<ObservationSession>? ownSessions,
    List<ObservationSession>? participatedSessions,
    bool? isLoadingHistory,
    bool? isLoadingParticipated,
    bool? isSyncing,
    bool? hasMoreHistory,
    bool? hasMoreParticipated,
    Object? historyError = _absent,
    Object? participatedError = _absent,
    Object? syncError = _absent,
  }) {
    return SessionListData(
      ownSessions: ownSessions ?? this.ownSessions,
      participatedSessions: participatedSessions ?? this.participatedSessions,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
      isLoadingParticipated:
          isLoadingParticipated ?? this.isLoadingParticipated,
      isSyncing: isSyncing ?? this.isSyncing,
      hasMoreHistory: hasMoreHistory ?? this.hasMoreHistory,
      hasMoreParticipated: hasMoreParticipated ?? this.hasMoreParticipated,
      historyError: identical(historyError, _absent)
          ? this.historyError
          : historyError as Failure?,
      participatedError: identical(participatedError, _absent)
          ? this.participatedError
          : participatedError as Failure?,
      syncError: identical(syncError, _absent)
          ? this.syncError
          : syncError as Failure?,
    );
  }

  @override
  List<Object?> get props => [
    ownSessions,
    participatedSessions,
    isLoadingHistory,
    isLoadingParticipated,
    isSyncing,
    hasMoreHistory,
    hasMoreParticipated,
    historyError,
    participatedError,
    syncError,
  ];
}

const _absent = Object();
