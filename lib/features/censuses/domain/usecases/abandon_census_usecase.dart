import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

class AbandonCensusUseCase {
  const AbandonCensusUseCase(this._repository);

  final CensusRepository _repository;

  Future<Result<Unit>> call(String censusId) async {
    final result = await _repository.getById(censusId);
    return result.when(
      failure: Err.new,
      success: (census) async {
        if (census == null) return const Err(CensusNotFoundFailure());
        return _repository.save(census.abandon());
      },
    );
  }
}
