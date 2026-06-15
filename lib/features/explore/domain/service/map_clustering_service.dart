import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:noctambuls/features/explore/domain/entities/bubble_cluster.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bounds.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';

class MapClusteringService {
  const MapClusteringService();

  Future<List<BubbleCluster>> clusterize({
    required List<MapBubble> bubbles,
    required MapBounds bounds,
    required double zoom,
  }) {
    return Isolate.run(() {
      const gridSize = 50.0;
      const tileSize = 256.0;
      final scale = tileSize * pow(2.0, zoom);

      final entries = <({int gx, int gy, MapBubble bubble})>[];
      for (final b in bubbles) {
        if (!bounds.contains(b.lat, b.lon)) continue;

        final px = (b.lon + 180.0) / 360.0 * scale;
        final latRad = b.lat * pi / 180.0;
        final py =
            (1.0 - log(tan(latRad) + 1.0 / cos(latRad)) / pi) / 2.0 * scale;
        entries.add((
          gx: (px / gridSize).floor(),
          gy: (py / gridSize).floor(),
          bubble: b,
        ));
      }

      final cells = <(int, int), List<MapBubble>>{};
      for (final e in entries) {
        cells.putIfAbsent((e.gx, e.gy), () => []).add(e.bubble);
      }

      return cells.values
          .where((group) => group.fold(0, (s, b) => s + b.count) > 0)
          .map((group) {
        final totalCount = group.fold(0, (s, b) => s + b.count);
        final lat = group.fold(0.0, (s, b) => s + b.lat * b.count) / totalCount;
        final lon = group.fold(0.0, (s, b) => s + b.lon * b.count) / totalCount;
        final isMulti =
            group.length > 1 ||
            group.map((b) => b.speciesId).toSet().length > 1;

        return BubbleCluster(
          lat: lat,
          lon: lon,
          count: totalCount,
          speciesId: isMulti ? null : group.first.speciesId,
          year: isMulti ? null : group.first.year,
        );
      }).toList();
    });
  }
}
