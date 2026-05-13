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

 String get id; String get annotatorId; SessionType get sessionType; bool get isLocked; SyncStatus get syncStatus; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted; TemperatureRange get temperature; WindLevel get wind; SkyCondition get sky; RainLevel get rain; VisibilityLevel get visibility; MoonPresence get moon; List<String> get participants; List<ObservationRecordModel> get observations; DateTime? get startTime; DateTime? get endTime; int? get listeningPoint; GeoPosition? get location; LocationErrorType? get locationError;
/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationSessionModelCopyWith<ObservationSessionModel> get copyWith => _$ObservationSessionModelCopyWithImpl<ObservationSessionModel>(this as ObservationSessionModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.observations, observations)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationError, locationError) || other.locationError == locationError));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,isLocked,syncStatus,createdAt,updatedAt,isDeleted,temperature,wind,sky,rain,visibility,moon,const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(observations),startTime,endTime,listeningPoint,location,locationError]);

@override
String toString() {
  return 'ObservationSessionModel(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, isLocked: $isLocked, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, participants: $participants, observations: $observations, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, location: $location, locationError: $locationError)';
}


}

/// @nodoc
abstract mixin class $ObservationSessionModelCopyWith<$Res>  {
  factory $ObservationSessionModelCopyWith(ObservationSessionModel value, $Res Function(ObservationSessionModel) _then) = _$ObservationSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String annotatorId, SessionType sessionType, bool isLocked, SyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, bool isDeleted, TemperatureRange temperature, WindLevel wind, SkyCondition sky, RainLevel rain, VisibilityLevel visibility, MoonPresence moon, List<String> participants, List<ObservationRecordModel> observations, DateTime? startTime, DateTime? endTime, int? listeningPoint, GeoPosition? location, LocationErrorType? locationError
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? isLocked = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? participants = null,Object? observations = null,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? location = freezed,Object? locationError = freezed,}) {
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
as MoonPresence,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,observations: null == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<ObservationRecordModel>,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPosition?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  List<String> participants,  List<ObservationRecordModel> observations,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  GeoPosition? location,  LocationErrorType? locationError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.participants,_that.observations,_that.startTime,_that.endTime,_that.listeningPoint,_that.location,_that.locationError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  List<String> participants,  List<ObservationRecordModel> observations,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  GeoPosition? location,  LocationErrorType? locationError)  $default,) {final _that = this;
switch (_that) {
case _ObservationSessionModel():
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.participants,_that.observations,_that.startTime,_that.endTime,_that.listeningPoint,_that.location,_that.locationError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String annotatorId,  SessionType sessionType,  bool isLocked,  SyncStatus syncStatus,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  TemperatureRange temperature,  WindLevel wind,  SkyCondition sky,  RainLevel rain,  VisibilityLevel visibility,  MoonPresence moon,  List<String> participants,  List<ObservationRecordModel> observations,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  GeoPosition? location,  LocationErrorType? locationError)?  $default,) {final _that = this;
switch (_that) {
case _ObservationSessionModel() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.isLocked,_that.syncStatus,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.participants,_that.observations,_that.startTime,_that.endTime,_that.listeningPoint,_that.location,_that.locationError);case _:
  return null;

}
}

}

/// @nodoc


class _ObservationSessionModel implements ObservationSessionModel {
  const _ObservationSessionModel({required this.id, required this.annotatorId, required this.sessionType, required this.isLocked, required this.syncStatus, required this.createdAt, required this.updatedAt, required this.isDeleted, this.temperature = TemperatureRange.belowZero, this.wind = WindLevel.calm, this.sky = SkyCondition.clear, this.rain = RainLevel.none, this.visibility = VisibilityLevel.poor, this.moon = MoonPresence.absent, final  List<String> participants = const [], final  List<ObservationRecordModel> observations = const [], this.startTime, this.endTime, this.listeningPoint, this.location, this.locationError}): _participants = participants,_observations = observations;
  

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
 final  List<String> _participants;
@override@JsonKey() List<String> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

 final  List<ObservationRecordModel> _observations;
@override@JsonKey() List<ObservationRecordModel> get observations {
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observations);
}

@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  int? listeningPoint;
@override final  GeoPosition? location;
@override final  LocationErrorType? locationError;

/// Create a copy of ObservationSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationSessionModelCopyWith<_ObservationSessionModel> get copyWith => __$ObservationSessionModelCopyWithImpl<_ObservationSessionModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._observations, _observations)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.location, location) || other.location == location)&&(identical(other.locationError, locationError) || other.locationError == locationError));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,isLocked,syncStatus,createdAt,updatedAt,isDeleted,temperature,wind,sky,rain,visibility,moon,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_observations),startTime,endTime,listeningPoint,location,locationError]);

@override
String toString() {
  return 'ObservationSessionModel(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, isLocked: $isLocked, syncStatus: $syncStatus, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, participants: $participants, observations: $observations, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, location: $location, locationError: $locationError)';
}


}

/// @nodoc
abstract mixin class _$ObservationSessionModelCopyWith<$Res> implements $ObservationSessionModelCopyWith<$Res> {
  factory _$ObservationSessionModelCopyWith(_ObservationSessionModel value, $Res Function(_ObservationSessionModel) _then) = __$ObservationSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String annotatorId, SessionType sessionType, bool isLocked, SyncStatus syncStatus, DateTime createdAt, DateTime updatedAt, bool isDeleted, TemperatureRange temperature, WindLevel wind, SkyCondition sky, RainLevel rain, VisibilityLevel visibility, MoonPresence moon, List<String> participants, List<ObservationRecordModel> observations, DateTime? startTime, DateTime? endTime, int? listeningPoint, GeoPosition? location, LocationErrorType? locationError
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? isLocked = null,Object? syncStatus = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? participants = null,Object? observations = null,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? location = freezed,Object? locationError = freezed,}) {
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
as MoonPresence,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<String>,observations: null == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<ObservationRecordModel>,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPosition?,locationError: freezed == locationError ? _self.locationError : locationError // ignore: cast_nullable_to_non_nullable
as LocationErrorType?,
  ));
}


}

// dart format on
