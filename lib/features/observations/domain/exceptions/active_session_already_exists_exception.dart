import 'package:noctambuls/core/exceptions/domain_exception.dart';

/// Throw when an active (non-locked) session exists in DB
class ActiveSessionAlreadyExistsException extends DomainException {
  const ActiveSessionAlreadyExistsException();
}
