import 'package:noctambuls/core/domain/error/domain_exception.dart';

class SessionUpdateException extends DomainException {
  const SessionUpdateException() : super("Can't modify locked session");
}

class ObservationMissingLocationException extends DomainException {
  const ObservationMissingLocationException()
    : super('Incidental observations require location');
}

class InvalidParticipantCodeException extends DomainException {
  const InvalidParticipantCodeException()
    : super('Participant code format invalid');
}

class InvalidSessionTimeException extends DomainException {
  const InvalidSessionTimeException()
    : super('Start time cant be before end date');
}
