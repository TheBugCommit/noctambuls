import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

class GetCensusUseCase {
  const GetCensusUseCase(this._repository);

  final CensusRepository _repository;

  Future<Result<Census?>> call(String id) => _repository.getById(id);
}
