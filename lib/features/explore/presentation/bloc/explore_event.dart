import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/explore/domain/entities/bubble_cluster.dart';
import 'package:noctambuls/features/explore/domain/entities/explore_filters.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bounds.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

final class ExploreStarted extends ExploreEvent {
  const ExploreStarted({required this.languageCode});

  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

final class ExploreRetrySync extends ExploreEvent {
  const ExploreRetrySync();
}

final class ExploreFilterChanged extends ExploreEvent {
  const ExploreFilterChanged({required this.filters});

  final ExploreFilters filters;

  @override
  List<Object?> get props => [filters];
}

final class ExploreMapCameraChanged extends ExploreEvent {
  const ExploreMapCameraChanged({required this.bounds, required this.zoom});

  final MapBounds? bounds;
  final double zoom;

  @override
  List<Object?> get props => [bounds, zoom];
}

final class ExploreBubbleTapped extends ExploreEvent {
  const ExploreBubbleTapped({required this.cluster});

  final BubbleCluster? cluster;

  @override
  List<Object?> get props => [cluster];
}
