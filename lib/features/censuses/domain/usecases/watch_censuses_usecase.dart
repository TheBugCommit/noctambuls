import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/repositories/census_repository.dart';

class WatchCensusesUseCase {
  const WatchCensusesUseCase(this._repository);

  final CensusRepository _repository;

  Stream<List<Census>> call() => _repository.watchAll();
}
