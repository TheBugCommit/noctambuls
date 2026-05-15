import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

class FetchCensusesUseCase {
  const FetchCensusesUseCase(this._repository);

  final CensusRepository _repository;

  Future<Result<Unit>> call() => _repository.fetchAndSync();
}
