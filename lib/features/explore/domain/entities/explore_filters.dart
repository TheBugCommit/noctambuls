import 'package:equatable/equatable.dart';
import 'package:noctambuls/features/explore/domain/entities/map_bubble.dart';

class ExploreFilters extends Equatable {
  const ExploreFilters({
    this.speciesId,
    this.selectedYears = const {},
  });

  final String? speciesId;
  final Set<int> selectedYears;

  bool get isHistoric => selectedYears.isEmpty;

  List<MapBubble> apply(List<MapBubble> bubbles) {
    var result = bubbles;
    if (speciesId != null) {
      result = result.where((b) => b.speciesId == speciesId).toList();
    }
    if (selectedYears.isNotEmpty) {
      result = result.where((b) => selectedYears.contains(b.year)).toList();
    }
    return result;
  }

  ExploreFilters copyWith({
    Object? speciesId = _absent,
    Set<int>? selectedYears,
  }) {
    return ExploreFilters(
      speciesId: speciesId == _absent ? this.speciesId : speciesId as String?,
      selectedYears: selectedYears ?? this.selectedYears,
    );
  }

  @override
  List<Object?> get props => [speciesId, selectedYears];
}

const _absent = Object();
