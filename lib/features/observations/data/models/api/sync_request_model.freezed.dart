// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncRequestModel {

 List<SyncSessionDto> get sessions;
/// Create a copy of SyncRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncRequestModelCopyWith<SyncRequestModel> get copyWith => _$SyncRequestModelCopyWithImpl<SyncRequestModel>(this as SyncRequestModel, _$identity);

  /// Serializes this SyncRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncRequestModel&&const DeepCollectionEquality().equals(other.sessions, sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessions));

@override
String toString() {
  return 'SyncRequestModel(sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $SyncRequestModelCopyWith<$Res>  {
  factory $SyncRequestModelCopyWith(SyncRequestModel value, $Res Function(SyncRequestModel) _then) = _$SyncRequestModelCopyWithImpl;
@useResult
$Res call({
 List<SyncSessionDto> sessions
});




}
/// @nodoc
class _$SyncRequestModelCopyWithImpl<$Res>
    implements $SyncRequestModelCopyWith<$Res> {
  _$SyncRequestModelCopyWithImpl(this._self, this._then);

  final SyncRequestModel _self;
  final $Res Function(SyncRequestModel) _then;

/// Create a copy of SyncRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SyncSessionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncRequestModel].
extension SyncRequestModelPatterns on SyncRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SyncRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SyncRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SyncSessionDto> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncRequestModel() when $default != null:
return $default(_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SyncSessionDto> sessions)  $default,) {final _that = this;
switch (_that) {
case _SyncRequestModel():
return $default(_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SyncSessionDto> sessions)?  $default,) {final _that = this;
switch (_that) {
case _SyncRequestModel() when $default != null:
return $default(_that.sessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncRequestModel implements SyncRequestModel {
  const _SyncRequestModel({required final  List<SyncSessionDto> sessions}): _sessions = sessions;
  factory _SyncRequestModel.fromJson(Map<String, dynamic> json) => _$SyncRequestModelFromJson(json);

 final  List<SyncSessionDto> _sessions;
@override List<SyncSessionDto> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of SyncRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncRequestModelCopyWith<_SyncRequestModel> get copyWith => __$SyncRequestModelCopyWithImpl<_SyncRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncRequestModel&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'SyncRequestModel(sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$SyncRequestModelCopyWith<$Res> implements $SyncRequestModelCopyWith<$Res> {
  factory _$SyncRequestModelCopyWith(_SyncRequestModel value, $Res Function(_SyncRequestModel) _then) = __$SyncRequestModelCopyWithImpl;
@override @useResult
$Res call({
 List<SyncSessionDto> sessions
});




}
/// @nodoc
class __$SyncRequestModelCopyWithImpl<$Res>
    implements _$SyncRequestModelCopyWith<$Res> {
  __$SyncRequestModelCopyWithImpl(this._self, this._then);

  final _SyncRequestModel _self;
  final $Res Function(_SyncRequestModel) _then;

/// Create a copy of SyncRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,}) {
  return _then(_SyncRequestModel(
sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SyncSessionDto>,
  ));
}


}


/// @nodoc
mixin _$SyncSessionDto {

 String get id; int get sessionType; String get startTime; String get endTime; int get temperature; int get wind; int get sky; int get rain; int get visibility; int get moon; String get createdAt; String get updatedAt; List<SyncObservationDto> get observations; List<SyncParticipantDto> get participants; String? get censusId; int? get listeningPoint; double? get latitude; double? get longitude; double? get accuracy; double? get altitude; double? get altitudeAccuracy; int? get locationSource;
/// Create a copy of SyncSessionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncSessionDtoCopyWith<SyncSessionDto> get copyWith => _$SyncSessionDtoCopyWithImpl<SyncSessionDto>(this as SyncSessionDto, _$identity);

  /// Serializes this SyncSessionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.censusId, censusId) || other.censusId == censusId)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sessionType,startTime,endTime,temperature,wind,sky,rain,visibility,moon,createdAt,updatedAt,const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(participants),censusId,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource]);

@override
String toString() {
  return 'SyncSessionDto(id: $id, sessionType: $sessionType, startTime: $startTime, endTime: $endTime, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, createdAt: $createdAt, updatedAt: $updatedAt, observations: $observations, participants: $participants, censusId: $censusId, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class $SyncSessionDtoCopyWith<$Res>  {
  factory $SyncSessionDtoCopyWith(SyncSessionDto value, $Res Function(SyncSessionDto) _then) = _$SyncSessionDtoCopyWithImpl;
@useResult
$Res call({
 String id, int sessionType, String startTime, String endTime, int temperature, int wind, int sky, int rain, int visibility, int moon, String createdAt, String updatedAt, List<SyncObservationDto> observations, List<SyncParticipantDto> participants, String? censusId, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class _$SyncSessionDtoCopyWithImpl<$Res>
    implements $SyncSessionDtoCopyWith<$Res> {
  _$SyncSessionDtoCopyWithImpl(this._self, this._then);

  final SyncSessionDto _self;
  final $Res Function(SyncSessionDto) _then;

/// Create a copy of SyncSessionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionType = null,Object? startTime = null,Object? endTime = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? createdAt = null,Object? updatedAt = null,Object? observations = null,Object? participants = null,Object? censusId = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as int,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as int,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,observations: null == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<SyncObservationDto>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<SyncParticipantDto>,censusId: freezed == censusId ? _self.censusId : censusId // ignore: cast_nullable_to_non_nullable
as String?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,locationSource: freezed == locationSource ? _self.locationSource : locationSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncSessionDto].
extension SyncSessionDtoPatterns on SyncSessionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncSessionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncSessionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncSessionDto value)  $default,){
final _that = this;
switch (_that) {
case _SyncSessionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncSessionDto value)?  $default,){
final _that = this;
switch (_that) {
case _SyncSessionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int sessionType,  String startTime,  String endTime,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  String createdAt,  String updatedAt,  List<SyncObservationDto> observations,  List<SyncParticipantDto> participants,  String? censusId,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncSessionDto() when $default != null:
return $default(_that.id,_that.sessionType,_that.startTime,_that.endTime,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.observations,_that.participants,_that.censusId,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int sessionType,  String startTime,  String endTime,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  String createdAt,  String updatedAt,  List<SyncObservationDto> observations,  List<SyncParticipantDto> participants,  String? censusId,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)  $default,) {final _that = this;
switch (_that) {
case _SyncSessionDto():
return $default(_that.id,_that.sessionType,_that.startTime,_that.endTime,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.observations,_that.participants,_that.censusId,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int sessionType,  String startTime,  String endTime,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  String createdAt,  String updatedAt,  List<SyncObservationDto> observations,  List<SyncParticipantDto> participants,  String? censusId,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,) {final _that = this;
switch (_that) {
case _SyncSessionDto() when $default != null:
return $default(_that.id,_that.sessionType,_that.startTime,_that.endTime,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.observations,_that.participants,_that.censusId,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncSessionDto implements SyncSessionDto {
  const _SyncSessionDto({required this.id, required this.sessionType, required this.startTime, required this.endTime, required this.temperature, required this.wind, required this.sky, required this.rain, required this.visibility, required this.moon, required this.createdAt, required this.updatedAt, required final  List<SyncObservationDto> observations, required final  List<SyncParticipantDto> participants, this.censusId, this.listeningPoint, this.latitude, this.longitude, this.accuracy, this.altitude, this.altitudeAccuracy, this.locationSource}): _observations = observations,_participants = participants;
  factory _SyncSessionDto.fromJson(Map<String, dynamic> json) => _$SyncSessionDtoFromJson(json);

@override final  String id;
@override final  int sessionType;
@override final  String startTime;
@override final  String endTime;
@override final  int temperature;
@override final  int wind;
@override final  int sky;
@override final  int rain;
@override final  int visibility;
@override final  int moon;
@override final  String createdAt;
@override final  String updatedAt;
 final  List<SyncObservationDto> _observations;
@override List<SyncObservationDto> get observations {
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observations);
}

 final  List<SyncParticipantDto> _participants;
@override List<SyncParticipantDto> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  String? censusId;
@override final  int? listeningPoint;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  double? altitude;
@override final  double? altitudeAccuracy;
@override final  int? locationSource;

/// Create a copy of SyncSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncSessionDtoCopyWith<_SyncSessionDto> get copyWith => __$SyncSessionDtoCopyWithImpl<_SyncSessionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncSessionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncSessionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.censusId, censusId) || other.censusId == censusId)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,sessionType,startTime,endTime,temperature,wind,sky,rain,visibility,moon,createdAt,updatedAt,const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_participants),censusId,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource]);

@override
String toString() {
  return 'SyncSessionDto(id: $id, sessionType: $sessionType, startTime: $startTime, endTime: $endTime, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, createdAt: $createdAt, updatedAt: $updatedAt, observations: $observations, participants: $participants, censusId: $censusId, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class _$SyncSessionDtoCopyWith<$Res> implements $SyncSessionDtoCopyWith<$Res> {
  factory _$SyncSessionDtoCopyWith(_SyncSessionDto value, $Res Function(_SyncSessionDto) _then) = __$SyncSessionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, int sessionType, String startTime, String endTime, int temperature, int wind, int sky, int rain, int visibility, int moon, String createdAt, String updatedAt, List<SyncObservationDto> observations, List<SyncParticipantDto> participants, String? censusId, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class __$SyncSessionDtoCopyWithImpl<$Res>
    implements _$SyncSessionDtoCopyWith<$Res> {
  __$SyncSessionDtoCopyWithImpl(this._self, this._then);

  final _SyncSessionDto _self;
  final $Res Function(_SyncSessionDto) _then;

/// Create a copy of SyncSessionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionType = null,Object? startTime = null,Object? endTime = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? createdAt = null,Object? updatedAt = null,Object? observations = null,Object? participants = null,Object? censusId = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_SyncSessionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as int,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as int,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,observations: null == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<SyncObservationDto>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<SyncParticipantDto>,censusId: freezed == censusId ? _self.censusId : censusId // ignore: cast_nullable_to_non_nullable
as String?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
as int?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,locationSource: freezed == locationSource ? _self.locationSource : locationSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SyncObservationDto {

 String get id; String get speciesId; int get contactType; int get quantity; String get startTime; String get endTime; String get createdAt; String get updatedAt; double get bearing; String? get notes; double? get latitude; double? get longitude; double? get accuracy; double? get altitude; double? get altitudeAccuracy; int? get locationSource;
/// Create a copy of SyncObservationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncObservationDtoCopyWith<SyncObservationDto> get copyWith => _$SyncObservationDtoCopyWithImpl<SyncObservationDto>(this as SyncObservationDto, _$identity);

  /// Serializes this SyncObservationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncObservationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,notes,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource);

@override
String toString() {
  return 'SyncObservationDto(id: $id, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, notes: $notes, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class $SyncObservationDtoCopyWith<$Res>  {
  factory $SyncObservationDtoCopyWith(SyncObservationDto value, $Res Function(SyncObservationDto) _then) = _$SyncObservationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String speciesId, int contactType, int quantity, String startTime, String endTime, String createdAt, String updatedAt, double bearing, String? notes, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class _$SyncObservationDtoCopyWithImpl<$Res>
    implements $SyncObservationDtoCopyWith<$Res> {
  _$SyncObservationDtoCopyWithImpl(this._self, this._then);

  final SyncObservationDto _self;
  final $Res Function(SyncObservationDto) _then;

/// Create a copy of SyncObservationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,locationSource: freezed == locationSource ? _self.locationSource : locationSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncObservationDto].
extension SyncObservationDtoPatterns on SyncObservationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncObservationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncObservationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncObservationDto value)  $default,){
final _that = this;
switch (_that) {
case _SyncObservationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncObservationDto value)?  $default,){
final _that = this;
switch (_that) {
case _SyncObservationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String speciesId,  int contactType,  int quantity,  String startTime,  String endTime,  String createdAt,  String updatedAt,  double bearing,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncObservationDto() when $default != null:
return $default(_that.id,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String speciesId,  int contactType,  int quantity,  String startTime,  String endTime,  String createdAt,  String updatedAt,  double bearing,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)  $default,) {final _that = this;
switch (_that) {
case _SyncObservationDto():
return $default(_that.id,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String speciesId,  int contactType,  int quantity,  String startTime,  String endTime,  String createdAt,  String updatedAt,  double bearing,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,) {final _that = this;
switch (_that) {
case _SyncObservationDto() when $default != null:
return $default(_that.id,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncObservationDto implements SyncObservationDto {
  const _SyncObservationDto({required this.id, required this.speciesId, required this.contactType, required this.quantity, required this.startTime, required this.endTime, required this.createdAt, required this.updatedAt, required this.bearing, this.notes, this.latitude, this.longitude, this.accuracy, this.altitude, this.altitudeAccuracy, this.locationSource});
  factory _SyncObservationDto.fromJson(Map<String, dynamic> json) => _$SyncObservationDtoFromJson(json);

@override final  String id;
@override final  String speciesId;
@override final  int contactType;
@override final  int quantity;
@override final  String startTime;
@override final  String endTime;
@override final  String createdAt;
@override final  String updatedAt;
@override final  double bearing;
@override final  String? notes;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  double? altitude;
@override final  double? altitudeAccuracy;
@override final  int? locationSource;

/// Create a copy of SyncObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncObservationDtoCopyWith<_SyncObservationDto> get copyWith => __$SyncObservationDtoCopyWithImpl<_SyncObservationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncObservationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncObservationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,notes,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource);

@override
String toString() {
  return 'SyncObservationDto(id: $id, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, notes: $notes, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class _$SyncObservationDtoCopyWith<$Res> implements $SyncObservationDtoCopyWith<$Res> {
  factory _$SyncObservationDtoCopyWith(_SyncObservationDto value, $Res Function(_SyncObservationDto) _then) = __$SyncObservationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String speciesId, int contactType, int quantity, String startTime, String endTime, String createdAt, String updatedAt, double bearing, String? notes, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class __$SyncObservationDtoCopyWithImpl<$Res>
    implements _$SyncObservationDtoCopyWith<$Res> {
  __$SyncObservationDtoCopyWithImpl(this._self, this._then);

  final _SyncObservationDto _self;
  final $Res Function(_SyncObservationDto) _then;

/// Create a copy of SyncObservationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_SyncObservationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,altitude: freezed == altitude ? _self.altitude : altitude // ignore: cast_nullable_to_non_nullable
as double?,altitudeAccuracy: freezed == altitudeAccuracy ? _self.altitudeAccuracy : altitudeAccuracy // ignore: cast_nullable_to_non_nullable
as double?,locationSource: freezed == locationSource ? _self.locationSource : locationSource // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SyncParticipantDto {

 String get ornithologistCode;
/// Create a copy of SyncParticipantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncParticipantDtoCopyWith<SyncParticipantDto> get copyWith => _$SyncParticipantDtoCopyWithImpl<SyncParticipantDto>(this as SyncParticipantDto, _$identity);

  /// Serializes this SyncParticipantDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncParticipantDto&&(identical(other.ornithologistCode, ornithologistCode) || other.ornithologistCode == ornithologistCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ornithologistCode);

@override
String toString() {
  return 'SyncParticipantDto(ornithologistCode: $ornithologistCode)';
}


}

/// @nodoc
abstract mixin class $SyncParticipantDtoCopyWith<$Res>  {
  factory $SyncParticipantDtoCopyWith(SyncParticipantDto value, $Res Function(SyncParticipantDto) _then) = _$SyncParticipantDtoCopyWithImpl;
@useResult
$Res call({
 String ornithologistCode
});




}
/// @nodoc
class _$SyncParticipantDtoCopyWithImpl<$Res>
    implements $SyncParticipantDtoCopyWith<$Res> {
  _$SyncParticipantDtoCopyWithImpl(this._self, this._then);

  final SyncParticipantDto _self;
  final $Res Function(SyncParticipantDto) _then;

/// Create a copy of SyncParticipantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ornithologistCode = null,}) {
  return _then(_self.copyWith(
ornithologistCode: null == ornithologistCode ? _self.ornithologistCode : ornithologistCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncParticipantDto].
extension SyncParticipantDtoPatterns on SyncParticipantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncParticipantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncParticipantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncParticipantDto value)  $default,){
final _that = this;
switch (_that) {
case _SyncParticipantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncParticipantDto value)?  $default,){
final _that = this;
switch (_that) {
case _SyncParticipantDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ornithologistCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncParticipantDto() when $default != null:
return $default(_that.ornithologistCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ornithologistCode)  $default,) {final _that = this;
switch (_that) {
case _SyncParticipantDto():
return $default(_that.ornithologistCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ornithologistCode)?  $default,) {final _that = this;
switch (_that) {
case _SyncParticipantDto() when $default != null:
return $default(_that.ornithologistCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncParticipantDto implements SyncParticipantDto {
  const _SyncParticipantDto({required this.ornithologistCode});
  factory _SyncParticipantDto.fromJson(Map<String, dynamic> json) => _$SyncParticipantDtoFromJson(json);

@override final  String ornithologistCode;

/// Create a copy of SyncParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncParticipantDtoCopyWith<_SyncParticipantDto> get copyWith => __$SyncParticipantDtoCopyWithImpl<_SyncParticipantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncParticipantDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncParticipantDto&&(identical(other.ornithologistCode, ornithologistCode) || other.ornithologistCode == ornithologistCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ornithologistCode);

@override
String toString() {
  return 'SyncParticipantDto(ornithologistCode: $ornithologistCode)';
}


}

/// @nodoc
abstract mixin class _$SyncParticipantDtoCopyWith<$Res> implements $SyncParticipantDtoCopyWith<$Res> {
  factory _$SyncParticipantDtoCopyWith(_SyncParticipantDto value, $Res Function(_SyncParticipantDto) _then) = __$SyncParticipantDtoCopyWithImpl;
@override @useResult
$Res call({
 String ornithologistCode
});




}
/// @nodoc
class __$SyncParticipantDtoCopyWithImpl<$Res>
    implements _$SyncParticipantDtoCopyWith<$Res> {
  __$SyncParticipantDtoCopyWithImpl(this._self, this._then);

  final _SyncParticipantDto _self;
  final $Res Function(_SyncParticipantDto) _then;

/// Create a copy of SyncParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ornithologistCode = null,}) {
  return _then(_SyncParticipantDto(
ornithologistCode: null == ornithologistCode ? _self.ornithologistCode : ornithologistCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
