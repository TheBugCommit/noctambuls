import 'package:equatable/equatable.dart';
import 'package:noctambuls/core/domain/entities/geo_position.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';

class ObservationRecord extends Equatable {
  const ObservationRecord({
    required this.id,
    required this.sessionId,
    required this.speciesId,
    required this.contactType,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.bearing,
    this.location,
    this.locationError,
    this.quantity = 1,
    this.notes,
    this.isDeleted = false,
  });

  final String id;
  final String sessionId;
  final String speciesId;
  final ContactType contactType;
  final int quantity;
  final DateTime startTime;
  final DateTime endTime;
  final String? notes;
  final GeoPosition? location;
  final LocationErrorType? locationError;
  final double bearing;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  static const Object _absent = Object();

  ObservationRecord copyWith({
    required DateTime updatedAt,
    DateTime? startTime,
    DateTime? endTime,
    Object? notes = _absent,
    Object? location = _absent,
    Object? locationError = _absent,
    double? bearing,
    int? quantity,
    bool? isDeleted,
  }) {
    return ObservationRecord(
      id: id,
      sessionId: sessionId,
      speciesId: speciesId,
      contactType: contactType,
      quantity: quantity ?? this.quantity,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: identical(notes, _absent) ? this.notes : notes as String?,
      location: identical(location, _absent)
          ? this.location
          : location as GeoPosition?,
      locationError: identical(locationError, _absent)
          ? this.locationError
          : locationError as LocationErrorType?,
      bearing: bearing ?? this.bearing,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
    id,
    sessionId,
    speciesId,
    contactType,
    quantity,
    startTime,
    endTime,
    notes,
    location,
    locationError,
    bearing,
    createdAt,
    updatedAt,
    isDeleted,
  ];
}
