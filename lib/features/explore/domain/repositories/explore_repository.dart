import 'package:noctambuls/core/domain/error/result.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';

abstract class ExploreRepository {
  Stream<List<MapBubble>> watchAll();

  Future<Result<Unit>> syncIfStale({bool force = false});


}
