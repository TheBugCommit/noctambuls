import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';
import 'package:noctambuls/features/explore/domain/repositories/explore_repository.dart';

class WatchMapBubblesUseCase {
  const WatchMapBubblesUseCase(this._repository);

  final ExploreRepository _repository;

  Stream<List<MapBubble>> call() => _repository.watchAll();
}
