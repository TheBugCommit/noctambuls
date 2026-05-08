// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObservationRecordModel {

 String get id; String get sessionId; String get speciesId; ContactType get contactType; int get quantity; DateTime get startTime; DateTime get endTime; DateTime get createdAt; DateTime get updatedAt; double get bearing; String? get notes; GeoPosition? get location; LocationErrorType? get locationError; ValidationStatus get validationStatus; SyncStatus get syncStatus; bool get isDeleted;
/// Create a copy of ObservationRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationRecordModelCopyWith<ObservationRecordModel> get copyWith => _$ObservationRecordModelCopyWithImpl<ObservationRecordModel>(this as ObservationRecordModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.validationStatus, validationStatus) || other.validationStatus == validationStatus)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,sessionId,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,notes,location,locationError,validationStatus,syncStatus,isDeleted);

@override
String toString() {
  return 'ObservationRecordModel(id: $id, sessionId: $sessionId, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, notes: $notes, location: $location, locationError: $locationError, validationStatus: $validationStatus, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $ObservationRecordModelCopyWith<$Res>  {
  factory $ObservationRecordModelCopyWith(ObservationRecordModel value, $Res Function(ObservationRecordModel) _then) = _$ObservationRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String speciesId, ContactType contactType, int quantity, DateTime startTime, DateTime endTime, DateTime createdAt, DateTime updatedAt, double bearing, String? notes, GeoPosition? location, LocationErrorType? locationError, ValidationStatus validationStatus, SyncStatus syncStatus, bool isDeleted
});




}
/// @nodoc
class _$ObservationRecordModelCopyWithImpl<$Res>
    implements $ObservationRecordModelCopyWith<$Res> {
  _$ObservationRecordModelCopyWithImpl(this._self, this._then);

  final ObservationRecordModel _self;
  final $Res Function(ObservationRecordModel) _then;

/// Create a copy of ObservationRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? notes = freezed,Object? location = freezed,Object? locationError = freezed,Object? validationStatus = null,Object? syncStatus = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as ContactType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPosition?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,validationStatus: null == validationStatus ? _self.validationStatus : validationStatus // ignore: cast_nullable_to_non_nullable
as ValidationStatus,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationRecordModel].
extension ObservationRecordModelPatterns on ObservationRecordModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationRecordModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _ObservationRecordModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationRecordModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String speciesId,  ContactType contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  String? notes,  GeoPosition? location,  LocationErrorType? locationError,  ValidationStatus validationStatus,  SyncStatus syncStatus,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationRecordModel() when $default != null:
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.location,_that.locationError,_that.validationStatus,_that.syncStatus,_that.isDeleted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String speciesId,  ContactType contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  String? notes,  GeoPosition? location,  LocationErrorType? locationError,  ValidationStatus validationStatus,  SyncStatus syncStatus,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _ObservationRecordModel():
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.location,_that.locationError,_that.validationStatus,_that.syncStatus,_that.isDeleted);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String speciesId,  ContactType contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  String? notes,  GeoPosition? location,  LocationErrorType? locationError,  ValidationStatus validationStatus,  SyncStatus syncStatus,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _ObservationRecordModel() when $default != null:
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.location,_that.locationError,_that.validationStatus,_that.syncStatus,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc


class _ObservationRecordModel implements ObservationRecordModel {
  const _ObservationRecordModel({required this.id, required this.sessionId, required this.speciesId, required this.contactType, required this.quantity, required this.startTime, required this.endTime, required this.createdAt, required this.updatedAt, required this.bearing, this.notes, this.location, this.locationError, this.validationStatus = ValidationStatus.pending, this.syncStatus = SyncStatus.draft, this.isDeleted = false});
  

@override final  String id;
@override final  String sessionId;
@override final  String speciesId;
@override final  ContactType contactType;
@override final  int quantity;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  double bearing;
@override final  String? notes;
@override final  GeoPosition? location;
@override final  LocationErrorType? locationError;
@override@JsonKey() final  ValidationStatus validationStatus;
@override@JsonKey() final  SyncStatus syncStatus;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of ObservationRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationRecordModelCopyWith<_ObservationRecordModel> get copyWith => __$ObservationRecordModelCopyWithImpl<_ObservationRecordModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&(identical(other.validationStatus, validationStatus) || other.validationStatus == validationStatus)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,sessionId,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,notes,location,locationError,validationStatus,syncStatus,isDeleted);

@override
String toString() {
  return 'ObservationRecordModel(id: $id, sessionId: $sessionId, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, notes: $notes, location: $location, locationError: $locationError, validationStatus: $validationStatus, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$ObservationRecordModelCopyWith<$Res> implements $ObservationRecordModelCopyWith<$Res> {
  factory _$ObservationRecordModelCopyWith(_ObservationRecordModel value, $Res Function(_ObservationRecordModel) _then) = __$ObservationRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String speciesId, ContactType contactType, int quantity, DateTime startTime, DateTime endTime, DateTime createdAt, DateTime updatedAt, double bearing, String? notes, GeoPosition? location, LocationErrorType? locationError, ValidationStatus validationStatus, SyncStatus syncStatus, bool isDeleted
});




}
/// @nodoc
class __$ObservationRecordModelCopyWithImpl<$Res>
    implements _$ObservationRecordModelCopyWith<$Res> {
  __$ObservationRecordModelCopyWithImpl(this._self, this._then);

  final _ObservationRecordModel _self;
  final $Res Function(_ObservationRecordModel) _then;

/// Create a copy of ObservationRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? notes = freezed,Object? location = freezed,Object? locationError = freezed,Object? validationStatus = null,Object? syncStatus = null,Object? isDeleted = null,}) {
  return _then(_ObservationRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as ContactType,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPosition?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,validationStatus: null == validationStatus ? _self.validationStatus : validationStatus // ignore: cast_nullable_to_non_nullable
as ValidationStatus,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
