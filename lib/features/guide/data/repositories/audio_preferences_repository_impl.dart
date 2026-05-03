import 'package:noctambuls/core/data/error/infrastrocture_failures.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/core/logging/app_logger.dart';
import 'package:noctambuls/features/guide/data/datasources/audio_preferences_local_datasource.dart';
import 'package:noctambuls/features/guide/domain/repositories/audio_preferences_repository.dart';

class AudioPreferencesRepositoryImpl implements AudioPreferencesRepository {
  const AudioPreferencesRepositoryImpl({
    required this.localDataSource,
    required this.logger,
  });

  final AudioPreferencesLocalDataSource localDataSource;
  final IAppLogger logger;

  @override
  Future<Result<bool>> hasAcceptedWarning() async {
    try {
      final hasAccepted = await localDataSource.hasAcceptedWarning();
      return Ok(hasAccepted);
    } catch (e, st) {
      final failure = const UnknownFailure().withDebug(e, st);
      logger.warning('Failed to read audio warning preference: $e');
      return Err(failure);
    }
  }

  @override
  Future<Result<Unit>> setWarningAccepted() async {
    try {
      await localDataSource.setWarningAccepted();
      return const Ok(Unit.instance);
    } catch (e, st) {
      final failure = const UnknownFailure().withDebug(e, st);
      logger.failure(failure);
      return Err(failure);
    }
  }
}
