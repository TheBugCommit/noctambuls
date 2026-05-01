import 'package:noctambuls/core/error/result.dart';

abstract class AudioPreferencesRepository {
  Future<Result<bool>> hasAcceptedWarning();

  Future<Result<Unit>> setWarningAccepted();
}
