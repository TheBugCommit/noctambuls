import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';

sealed class ActiveSessionEvent extends Equatable {
  const ActiveSessionEvent();

  @override
  List<Object?> get props => [];
}

class StartWatchingActiveSession extends ActiveSessionEvent {}

class OnActiveSessionUpdated extends ActiveSessionEvent {
  const OnActiveSessionUpdated(this.session);

  final ObservationSession? session;
}

class OnObservationsUpdated extends ActiveSessionEvent {
  const OnObservationsUpdated(this.observations);

  final List<ObservationRecord> observations;
}

class StartNewSession extends ActiveSessionEvent {
  const StartNewSession(this.session);

  final ObservationSession session;
}

class StopObservationPhase extends ActiveSessionEvent {}

class FinishAndLockSession extends ActiveSessionEvent {}

class UpdateSessionNotes extends ActiveSessionEvent {
  const UpdateSessionNotes({required this.weatherNotes});

  final String weatherNotes;
}

class AddRecord extends ActiveSessionEvent {
  const AddRecord(this.record);

  final ObservationRecord record;
}

class DeleteRecord extends ActiveSessionEvent {
  const DeleteRecord(this.recordId);

  final String recordId;
}
