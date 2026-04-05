import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

class ActiveSessionState extends Equatable {
  const ActiveSessionState({
    this.session,
    this.observations = const [],
  });

  final ObservationSession? session;
  final List<ObservationRecord> observations;

  bool get hasActiveSession => session != null;

  bool get isObserving => hasActiveSession && session!.isObserving;

  bool get isReviewing => hasActiveSession && session!.isReviewing;

  ActiveSessionState copyWith({
    ObservationSession? session,
    List<ObservationRecord>? observations,
    bool clearSession = false,
  }) {
    return ActiveSessionState(
      session: clearSession ? null : (session ?? this.session),
      observations: observations ?? this.observations,
    );
  }

  @override
  List<Object?> get props => [session, observations];
}
