import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';

class Census extends Equatable {
  const Census({
    required this.id,
    required this.title,
    required this.startTime,
    required this.createdAt,
    required this.updatedAt,
    this.locationName,
    this.description,
    this.geoPosition,
    this.isJoined = false,
    this.alreadyDone = false,
  });

  final String id;
  final String title;
  final DateTime startTime;
  final String? locationName;
  final String? description;
  final GeoPosition? geoPosition;
  final bool isJoined;
  final bool alreadyDone;
  final DateTime createdAt;
  final DateTime updatedAt;

  bool get isTodaysCensus {
    final today = DateTime.now().toLocal();
    final censusDate = startTime.toLocal();
    return censusDate.year == today.year &&
        censusDate.month == today.month &&
        censusDate.day == today.day;
  }

  Census join() => _copyWith(isJoined: true);

  Census abandon() => _copyWith(isJoined: false);

  Census markAsDone() => _copyWith(alreadyDone: true);

  Census _copyWith({bool? isJoined, bool? alreadyDone}) {
    return Census(
      id: id,
      title: title,
      startTime: startTime,
      locationName: locationName,
      description: description,
      geoPosition: geoPosition,
      isJoined: isJoined ?? this.isJoined,
      alreadyDone: alreadyDone ?? this.alreadyDone,
      createdAt: createdAt,
      updatedAt: DateTime.now().toUtc(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    startTime,
    locationName,
    description,
    geoPosition,
    isJoined,
    alreadyDone,
    createdAt,
    updatedAt,
  ];
}
