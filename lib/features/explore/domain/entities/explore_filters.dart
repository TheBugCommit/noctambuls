import 'package:equatable/equatable.dart';

class ExploreFilters extends Equatable {
  const ExploreFilters({
    this.speciesId,
    this.selectedYears = const {},
  });

  final String? speciesId;
  final Set<int> selectedYears;

  bool get isHistoric => selectedYears.isEmpty;

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
