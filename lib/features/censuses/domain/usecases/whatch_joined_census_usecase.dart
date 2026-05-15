import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

class WatchJoinedCensusUseCase {
  const WatchJoinedCensusUseCase(this._repository);

  final CensusRepository _repository;

  Stream<Census?> call() {
    return _repository.watchJoinedCensus();
  }
}
