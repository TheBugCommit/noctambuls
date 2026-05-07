// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'observation_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ObservationSessionModel {

 String get id; String get annotatorId; SessionType get sessionType; bool get isLocked; SyncStatus get syncStatus; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted; TemperatureRange get temperature; WindLevel get wind; SkyCondition get sky; RainLevel get rain; VisibilityLevel get visibility; MoonPresence get moon; DateTime? get startTime; DateTime? get endTime; int? get listeningPoint; double? get latitude; double? get longitude; double? get accuracy; double? get altitude; double? get altitudeAccuracy; DateTime? get positionTimestamp; LocationErrorType? get locationError; List<String> get participants;
/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationSessionModelCopyWith<ObservationSessionModel> get copyWith => _$ObservationSessionModelCopyWithImpl<ObservationSessionModel>(this as ObservationSessionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.positionTimestamp, positionTimestamp) || other.positionTimestamp == positionTimestamp)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&const DeepCollectionEquality().equals(other.participants, participants));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,isLocked,syncStatus,createdAt,updatedAt,isDeleted,temperature,wind,sky,rain,visibility,moon,startTime,endTime,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,positionTimestamp,locationError,const DeepCollectionEquality().hash(participants)]);

@override
String toString() {
  return 'ObservationSessionModel(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, isLocked: $isLocked, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, positionTimestamp: $positionTimestamp, locationError: $locationError, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $ObservationSessionModelCopyWith<$Res>  {
  factory $ObservationSessionModelCopyWith(ObservationSessionModel value, $Res Function(ObservationSessionModel) _then) = _$ObservationSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String annotatorId, SessionType sessionType, bool isLocked, SyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, bool isDeleted, TemperatureRange temperature, WindLevel wind, SkyCondition sky, RainLevel rain, VisibilityLevel visibility, MoonPresence moon, DateTime? startTime, DateTime? endTime, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, DateTime? positionTimestamp, LocationErrorType? locationError, List<String> participants
});




}
/// @nodoc
class _$ObservationSessionModelCopyWithImpl<$Res>
    implements $ObservationSessionModelCopyWith<$Res> {
  _$ObservationSessionModelCopyWithImpl(this._self, this._then);

  final ObservationSessionModel _self;
  final $Res Function(ObservationSessionModel) _then;

/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? isLocked = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? positionTimestamp = freezed,Object? locationError = freezed,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,annotatorId: null == annotatorId ? _self.annotatorId : annotatorId // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as SessionType,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as TemperatureRange,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindLevel,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as SkyCondition,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as RainLevel,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as VisibilityLevel,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as MoonPresence,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,positionTimestamp: freezed == positionTimestamp ? _self.positionTimestamp : positionTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ObservationSessionModel].
extension ObservationSessionModelPatterns on ObservationSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _ObservationSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  DateTime? positionTimestamp,  LocationErrorType? locationError,  List<String> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.positionTimestamp,_that.locationError,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  DateTime? positionTimestamp,  LocationErrorType? locationError,  List<String> participants)  $default,) {final _that = this;
switch (_that) {
case _ObservationSessionModel():
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.positionTimestamp,_that.locationError,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  DateTime? positionTimestamp,  LocationErrorType? locationError,  List<String> participants)?  $default,) {final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.positionTimestamp,_that.locationError,_that.participants);case _:
  return null;

}
}

}

/// @nodoc


class _ObservationSessionModel implements ObservationSessionModel {
  const _ObservationSessionModel({required this.id, required this.annotatorId, required this.sessionType, required this.isLocked, required this.syncStatus, required this.createdAt, required this.updatedAt, required this.isDeleted, this.temperature = TemperatureRange.belowZero, this.wind = WindLevel.calm, this.sky = SkyCondition.clear, this.rain = RainLevel.none, this.visibility = VisibilityLevel.poor, this.moon = MoonPresence.absent, this.startTime, this.endTime, this.listeningPoint, this.latitude, this.longitude, this.accuracy, this.altitude, this.altitudeAccuracy, this.positionTimestamp, this.locationError, final  List<String> participants = const []}): _participants = participants;
  

@override final  String id;
@override final  String annotatorId;
@override final  SessionType sessionType;
@override final  bool isLocked;
@override final  SyncStatus syncStatus;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool isDeleted;
@override@JsonKey() final  TemperatureRange temperature;
@override@JsonKey() final  WindLevel wind;
@override@JsonKey() final  SkyCondition sky;
@override@JsonKey() final  RainLevel rain;
@override@JsonKey() final  VisibilityLevel visibility;
@override@JsonKey() final  MoonPresence moon;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  int? listeningPoint;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  double? altitude;
@override final  double? altitudeAccuracy;
@override final  DateTime? positionTimestamp;
@override final  LocationErrorType? locationError;
 final  List<String> _participants;
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationSessionModelCopyWith<_ObservationSessionModel> get copyWith => __$ObservationSessionModelCopyWithImpl<_ObservationSessionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.positionTimestamp, positionTimestamp) || other.positionTimestamp == positionTimestamp)&&(identical(other.locationError, locationError) || other.locationError == locationError)&&const DeepCollectionEquality().equals(other._participants, _participants));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,isLocked,syncStatus,createdAt,updatedAt,isDeleted,temperature,wind,sky,rain,visibility,moon,startTime,endTime,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,positionTimestamp,locationError,const DeepCollectionEquality().hash(_participants)]);

@override
String toString() {
  return 'ObservationSessionModel(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, isLocked: $isLocked, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, positionTimestamp: $positionTimestamp, locationError: $locationError, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$ObservationSessionModelCopyWith<$Res> implements $ObservationSessionModelCopyWith<$Res> {
  factory _$ObservationSessionModelCopyWith(_ObservationSessionModel value, $Res Function(_ObservationSessionModel) _then) = __$ObservationSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String annotatorId, SessionType sessionType, bool isLocked, SyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, bool isDeleted, TemperatureRange temperature, WindLevel wind, SkyCondition sky, RainLevel rain, VisibilityLevel visibility, MoonPresence moon, DateTime? startTime, DateTime? endTime, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, DateTime? positionTimestamp, LocationErrorType? locationError, List<String> participants
});




}
/// @nodoc
class __$ObservationSessionModelCopyWithImpl<$Res>
    implements _$ObservationSessionModelCopyWith<$Res> {
  __$ObservationSessionModelCopyWithImpl(this._self, this._then);

  final _ObservationSessionModel _self;
  final $Res Function(_ObservationSessionModel) _then;

/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? isLocked = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? positionTimestamp = freezed,Object? locationError = freezed,Object? participants = null,}) {
  return _then(_ObservationSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,annotatorId: null == annotatorId ? _self.annotatorId : annotatorId // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as SessionType,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as TemperatureRange,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindLevel,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as SkyCondition,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as RainLevel,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as VisibilityLevel,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as MoonPresence,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,positionTimestamp: freezed == positionTimestamp ? _self.positionTimestamp : positionTimestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
