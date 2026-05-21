import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:noctambuls/core/constants/app_deeplinks.dart';
import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/domain/repositories/session_repository.dart';

class JoinCensusUseCase {
  const JoinCensusUseCase(
    this._repository,
    this._sessionRepository,
    this._publicKey,
  );

  final CensusRepository _repository;
  final SessionRepository _sessionRepository;
  final String _publicKey;

  Future<Result<Census>> call(String rawUrl) async {
    final activeSession = await _sessionRepository.getActiveSession();
    if (activeSession is Ok<ObservationSession?>) {
      if (activeSession.value != null) {
        return const Err(ActiveSessionAlreadyExistsFailure());
      }
    } else if (activeSession is Err<ObservationSession?>) {
      return Err(activeSession.failure);
    }

    final uri = Uri.tryParse(rawUrl);
    final token = uri != null ? AppDeepLinks.extractCensusToken(uri) : null;

    if (token == null || token.isEmpty) {
      return const Err(InvalidCensusTokenFailure());
    }

    JWT jwt;
    try {
      final publicKeyString = _publicKey.replaceAll(r'\n', '\n');
      jwt = JWT.verify(token, RSAPublicKey(publicKeyString));
    } catch (_) {
      return const Err(InvalidCensusTokenFailure());
    }

    final payload = jwt.payload;
    if (payload is! Map<String, dynamic>) {
      return const Err(InvalidCensusTokenFailure());
    }

    final censusId = payload['i'] as String?;
    final title = payload['t'] as String?;
    final startTimeStr = payload['s'] as String?;

    if (censusId == null || title == null || startTimeStr == null) {
      return const Err(InvalidCensusTokenFailure());
    }

    DateTime startTime;
    try {
      startTime = DateTime.parse(startTimeStr).toUtc();
    } catch (e) {
      return const Err(InvalidCensusTokenFailure());
    }

    final existingResult = await _repository.getById(censusId);
    if (existingResult is Err<Census?>) {
      return Err(existingResult.failure);
    }

    final existing = (existingResult as Ok<Census?>).value;
    if (existing != null && existing.alreadyDone) {
      return const Err(CensusSessionAlreadyFinishedFailure());
    }

    final nowUtc = DateTime.now().toUtc();
    final census =
        existing ??
        Census(
          id: censusId,
          title: title,
          startTime: startTime,
          createdAt: nowUtc,
          updatedAt: nowUtc,
        );

    if (!census.isTodaysCensus) {
      return const Err(CensusNotTodayFailure());
    }

    final joinedResult = await _repository.getJoinedCensus();
    if (joinedResult is Err<Census?>) {
      return Err(joinedResult.failure);
    }
    final joined = (joinedResult as Ok<Census?>).value;
    if (joined != null) {
      return const Err(CensusJoinAlreadyHasLobbyFailure());
    }

    final joinedCensus = census.join();

    final saveResult = await _repository.save(joinedCensus);
    return saveResult.when(
      failure: Err.new,
      success: (_) => Ok(census),
    );
  }
}
