// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_history_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionHistoryResponseModel {

 List<SessionRemoteDto> get sessions; PaginationMetaDto get meta; String get serverTime;
/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionHistoryResponseModelCopyWith<SessionHistoryResponseModel> get copyWith => _$SessionHistoryResponseModelCopyWithImpl<SessionHistoryResponseModel>(this as SessionHistoryResponseModel, _$identity);

  /// Serializes this SessionHistoryResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionHistoryResponseModel&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessions),meta,serverTime);

@override
String toString() {
  return 'SessionHistoryResponseModel(sessions: $sessions, meta: $meta, serverTime: $serverTime)';
}


}

/// @nodoc
abstract mixin class $SessionHistoryResponseModelCopyWith<$Res>  {
  factory $SessionHistoryResponseModelCopyWith(SessionHistoryResponseModel value, $Res Function(SessionHistoryResponseModel) _then) = _$SessionHistoryResponseModelCopyWithImpl;
@useResult
$Res call({
 List<SessionRemoteDto> sessions, PaginationMetaDto meta, String serverTime
});


$PaginationMetaDtoCopyWith<$Res> get meta;

}
/// @nodoc
class _$SessionHistoryResponseModelCopyWithImpl<$Res>
    implements $SessionHistoryResponseModelCopyWith<$Res> {
  _$SessionHistoryResponseModelCopyWithImpl(this._self, this._then);

  final SessionHistoryResponseModel _self;
  final $Res Function(SessionHistoryResponseModel) _then;

/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,Object? meta = null,Object? serverTime = null,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionRemoteDto>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMetaDto,serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaDtoCopyWith<$Res> get meta {
  
  return $PaginationMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// Adds pattern-matching-related methods to [SessionHistoryResponseModel].
extension SessionHistoryResponseModelPatterns on SessionHistoryResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionHistoryResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionHistoryResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SessionHistoryResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionHistoryResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SessionHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SessionRemoteDto> sessions,  PaginationMetaDto meta,  String serverTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionHistoryResponseModel() when $default != null:
return $default(_that.sessions,_that.meta,_that.serverTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SessionRemoteDto> sessions,  PaginationMetaDto meta,  String serverTime)  $default,) {final _that = this;
switch (_that) {
case _SessionHistoryResponseModel():
return $default(_that.sessions,_that.meta,_that.serverTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SessionRemoteDto> sessions,  PaginationMetaDto meta,  String serverTime)?  $default,) {final _that = this;
switch (_that) {
case _SessionHistoryResponseModel() when $default != null:
return $default(_that.sessions,_that.meta,_that.serverTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionHistoryResponseModel implements SessionHistoryResponseModel {
  const _SessionHistoryResponseModel({required final  List<SessionRemoteDto> sessions, required this.meta, required this.serverTime}): _sessions = sessions;
  factory _SessionHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$SessionHistoryResponseModelFromJson(json);

 final  List<SessionRemoteDto> _sessions;
@override List<SessionRemoteDto> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override final  PaginationMetaDto meta;
@override final  String serverTime;

/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionHistoryResponseModelCopyWith<_SessionHistoryResponseModel> get copyWith => __$SessionHistoryResponseModelCopyWithImpl<_SessionHistoryResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionHistoryResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionHistoryResponseModel&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.meta, meta) || other.meta == meta)&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions),meta,serverTime);

@override
String toString() {
  return 'SessionHistoryResponseModel(sessions: $sessions, meta: $meta, serverTime: $serverTime)';
}


}

/// @nodoc
abstract mixin class _$SessionHistoryResponseModelCopyWith<$Res> implements $SessionHistoryResponseModelCopyWith<$Res> {
  factory _$SessionHistoryResponseModelCopyWith(_SessionHistoryResponseModel value, $Res Function(_SessionHistoryResponseModel) _then) = __$SessionHistoryResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<SessionRemoteDto> sessions, PaginationMetaDto meta, String serverTime
});


@override $PaginationMetaDtoCopyWith<$Res> get meta;

}
/// @nodoc
class __$SessionHistoryResponseModelCopyWithImpl<$Res>
    implements _$SessionHistoryResponseModelCopyWith<$Res> {
  __$SessionHistoryResponseModelCopyWithImpl(this._self, this._then);

  final _SessionHistoryResponseModel _self;
  final $Res Function(_SessionHistoryResponseModel) _then;

/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,Object? meta = null,Object? serverTime = null,}) {
  return _then(_SessionHistoryResponseModel(
sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionRemoteDto>,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as PaginationMetaDto,serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SessionHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationMetaDtoCopyWith<$Res> get meta {
  
  return $PaginationMetaDtoCopyWith<$Res>(_self.meta, (value) {
    return _then(_self.copyWith(meta: value));
  });
}
}


/// @nodoc
mixin _$PaginationMetaDto {

 int get currentPage; int get totalPages; int get totalItems; bool get hasMore;
/// Create a copy of PaginationMetaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationMetaDtoCopyWith<PaginationMetaDto> get copyWith => _$PaginationMetaDtoCopyWithImpl<PaginationMetaDto>(this as PaginationMetaDto, _$identity);

  /// Serializes this PaginationMetaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationMetaDto&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,totalPages,totalItems,hasMore);

@override
String toString() {
  return 'PaginationMetaDto(currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $PaginationMetaDtoCopyWith<$Res>  {
  factory $PaginationMetaDtoCopyWith(PaginationMetaDto value, $Res Function(PaginationMetaDto) _then) = _$PaginationMetaDtoCopyWithImpl;
@useResult
$Res call({
 int currentPage, int totalPages, int totalItems, bool hasMore
});




}
/// @nodoc
class _$PaginationMetaDtoCopyWithImpl<$Res>
    implements $PaginationMetaDtoCopyWith<$Res> {
  _$PaginationMetaDtoCopyWithImpl(this._self, this._then);

  final PaginationMetaDto _self;
  final $Res Function(PaginationMetaDto) _then;

/// Create a copy of PaginationMetaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? totalPages = null,Object? totalItems = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationMetaDto].
extension PaginationMetaDtoPatterns on PaginationMetaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationMetaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationMetaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationMetaDto value)  $default,){
final _that = this;
switch (_that) {
case _PaginationMetaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationMetaDto value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationMetaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentPage,  int totalPages,  int totalItems,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationMetaDto() when $default != null:
return $default(_that.currentPage,_that.totalPages,_that.totalItems,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentPage,  int totalPages,  int totalItems,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _PaginationMetaDto():
return $default(_that.currentPage,_that.totalPages,_that.totalItems,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentPage,  int totalPages,  int totalItems,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _PaginationMetaDto() when $default != null:
return $default(_that.currentPage,_that.totalPages,_that.totalItems,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationMetaDto implements PaginationMetaDto {
  const _PaginationMetaDto({required this.currentPage, required this.totalPages, required this.totalItems, required this.hasMore});
  factory _PaginationMetaDto.fromJson(Map<String, dynamic> json) => _$PaginationMetaDtoFromJson(json);

@override final  int currentPage;
@override final  int totalPages;
@override final  int totalItems;
@override final  bool hasMore;

/// Create a copy of PaginationMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationMetaDtoCopyWith<_PaginationMetaDto> get copyWith => __$PaginationMetaDtoCopyWithImpl<_PaginationMetaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationMetaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationMetaDto&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,totalPages,totalItems,hasMore);

@override
String toString() {
  return 'PaginationMetaDto(currentPage: $currentPage, totalPages: $totalPages, totalItems: $totalItems, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$PaginationMetaDtoCopyWith<$Res> implements $PaginationMetaDtoCopyWith<$Res> {
  factory _$PaginationMetaDtoCopyWith(_PaginationMetaDto value, $Res Function(_PaginationMetaDto) _then) = __$PaginationMetaDtoCopyWithImpl;
@override @useResult
$Res call({
 int currentPage, int totalPages, int totalItems, bool hasMore
});




}
/// @nodoc
class __$PaginationMetaDtoCopyWithImpl<$Res>
    implements _$PaginationMetaDtoCopyWith<$Res> {
  __$PaginationMetaDtoCopyWithImpl(this._self, this._then);

  final _PaginationMetaDto _self;
  final $Res Function(_PaginationMetaDto) _then;

/// Create a copy of PaginationMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? totalPages = null,Object? totalItems = null,Object? hasMore = null,}) {
  return _then(_PaginationMetaDto(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SessionRemoteDto {

 String get id; String get annotatorId; int get sessionType; int get temperature; int get wind; int get sky; int get rain; int get visibility; int get moon; DateTime get createdAt; DateTime get updatedAt; bool get isDeleted; List<ObservationRemoteDto> get observations; List<ParticipantRemoteDto> get participants; String? get censusId; DateTime? get startTime; DateTime? get endTime; int? get listeningPoint; double? get latitude; double? get longitude; double? get accuracy; double? get altitude; double? get altitudeAccuracy; int? get locationSource;
/// Create a copy of SessionRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionRemoteDtoCopyWith<SessionRemoteDto> get copyWith => _$SessionRemoteDtoCopyWithImpl<SessionRemoteDto>(this as SessionRemoteDto, _$identity);

  /// Serializes this SessionRemoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other.observations, observations)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.censusId, censusId) || other.censusId == censusId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,temperature,wind,sky,rain,visibility,moon,createdAt,updatedAt,isDeleted,const DeepCollectionEquality().hash(observations),const DeepCollectionEquality().hash(participants),censusId,startTime,endTime,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource]);

@override
String toString() {
  return 'SessionRemoteDto(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, observations: $observations, participants: $participants, censusId: $censusId, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class $SessionRemoteDtoCopyWith<$Res>  {
  factory $SessionRemoteDtoCopyWith(SessionRemoteDto value, $Res Function(SessionRemoteDto) _then) = _$SessionRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String annotatorId, int sessionType, int temperature, int wind, int sky, int rain, int visibility, int moon, DateTime createdAt, DateTime updatedAt, bool isDeleted, List<ObservationRemoteDto> observations, List<ParticipantRemoteDto> participants, String? censusId, DateTime? startTime, DateTime? endTime, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class _$SessionRemoteDtoCopyWithImpl<$Res>
    implements $SessionRemoteDtoCopyWith<$Res> {
  _$SessionRemoteDtoCopyWithImpl(this._self, this._then);

  final SessionRemoteDto _self;
  final $Res Function(SessionRemoteDto) _then;

/// Create a copy of SessionRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? observations = null,Object? participants = null,Object? censusId = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,annotatorId: null == annotatorId ? _self.annotatorId : annotatorId // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as int,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as int,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,observations: null == observations ? _self.observations : observations // ignore: cast_nullable_to_non_nullable
as List<ObservationRemoteDto>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantRemoteDto>,censusId: freezed == censusId ? _self.censusId : censusId // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [SessionRemoteDto].
extension SessionRemoteDtoPatterns on SessionRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _SessionRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _SessionRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String annotatorId,  int sessionType,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  List<ObservationRemoteDto> observations,  List<ParticipantRemoteDto> participants,  String? censusId,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionRemoteDto() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.observations,_that.participants,_that.censusId,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String annotatorId,  int sessionType,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  List<ObservationRemoteDto> observations,  List<ParticipantRemoteDto> participants,  String? censusId,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)  $default,) {final _that = this;
switch (_that) {
case _SessionRemoteDto():
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.observations,_that.participants,_that.censusId,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String annotatorId,  int sessionType,  int temperature,  int wind,  int sky,  int rain,  int visibility,  int moon,  DateTime createdAt,  DateTime updatedAt,  bool isDeleted,  List<ObservationRemoteDto> observations,  List<ParticipantRemoteDto> participants,  String? censusId,  DateTime? startTime,  DateTime? endTime,  int? listeningPoint,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,) {final _that = this;
switch (_that) {
case _SessionRemoteDto() when $default != null:
return $default(_that.id,_that.annotatorId,_that.sessionType,_that.temperature,_that.wind,_that.sky,_that.rain,_that.visibility,_that.moon,_that.createdAt,_that.updatedAt,_that.isDeleted,_that.observations,_that.participants,_that.censusId,_that.startTime,_that.endTime,_that.listeningPoint,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionRemoteDto implements SessionRemoteDto {
  const _SessionRemoteDto({required this.id, required this.annotatorId, required this.sessionType, required this.temperature, required this.wind, required this.sky, required this.rain, required this.visibility, required this.moon, required this.createdAt, required this.updatedAt, required this.isDeleted, final  List<ObservationRemoteDto> observations = const [], final  List<ParticipantRemoteDto> participants = const [], this.censusId, this.startTime, this.endTime, this.listeningPoint, this.latitude, this.longitude, this.accuracy, this.altitude, this.altitudeAccuracy, this.locationSource}): _observations = observations,_participants = participants;
  factory _SessionRemoteDto.fromJson(Map<String, dynamic> json) => _$SessionRemoteDtoFromJson(json);

@override final  String id;
@override final  String annotatorId;
@override final  int sessionType;
@override final  int temperature;
@override final  int wind;
@override final  int sky;
@override final  int rain;
@override final  int visibility;
@override final  int moon;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  bool isDeleted;
 final  List<ObservationRemoteDto> _observations;
@override@JsonKey() List<ObservationRemoteDto> get observations {
  if (_observations is EqualUnmodifiableListView) return _observations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_observations);
}

 final  List<ParticipantRemoteDto> _participants;
@override@JsonKey() List<ParticipantRemoteDto> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  String? censusId;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  int? listeningPoint;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  double? altitude;
@override final  double? altitudeAccuracy;
@override final  int? locationSource;

/// Create a copy of SessionRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRemoteDtoCopyWith<_SessionRemoteDto> get copyWith => __$SessionRemoteDtoCopyWithImpl<_SessionRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionRemoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.annotatorId, annotatorId) || other.annotatorId == annotatorId)&&(identical(other.sessionType, sessionType) || other.sessionType == sessionType)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.wind, wind) || other.wind == wind)&&(identical(other.sky, sky) || other.sky == sky)&&(identical(other.rain, rain) || other.rain == rain)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.moon, moon) || other.moon == moon)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&const DeepCollectionEquality().equals(other._observations, _observations)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.censusId, censusId) || other.censusId == censusId)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.listeningPoint, listeningPoint) || other.listeningPoint == listeningPoint)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,annotatorId,sessionType,temperature,wind,sky,rain,visibility,moon,createdAt,updatedAt,isDeleted,const DeepCollectionEquality().hash(_observations),const DeepCollectionEquality().hash(_participants),censusId,startTime,endTime,listeningPoint,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource]);

@override
String toString() {
  return 'SessionRemoteDto(id: $id, annotatorId: $annotatorId, sessionType: $sessionType, temperature: $temperature, wind: $wind, sky: $sky, rain: $rain, visibility: $visibility, moon: $moon, createdAt: $createdAt, updatedAt: $updatedAt, isDeleted: $isDeleted, observations: $observations, participants: $participants, censusId: $censusId, startTime: $startTime, endTime: $endTime, listeningPoint: $listeningPoint, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class _$SessionRemoteDtoCopyWith<$Res> implements $SessionRemoteDtoCopyWith<$Res> {
  factory _$SessionRemoteDtoCopyWith(_SessionRemoteDto value, $Res Function(_SessionRemoteDto) _then) = __$SessionRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String annotatorId, int sessionType, int temperature, int wind, int sky, int rain, int visibility, int moon, DateTime createdAt, DateTime updatedAt, bool isDeleted, List<ObservationRemoteDto> observations, List<ParticipantRemoteDto> participants, String? censusId, DateTime? startTime, DateTime? endTime, int? listeningPoint, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class __$SessionRemoteDtoCopyWithImpl<$Res>
    implements _$SessionRemoteDtoCopyWith<$Res> {
  __$SessionRemoteDtoCopyWithImpl(this._self, this._then);

  final _SessionRemoteDto _self;
  final $Res Function(_SessionRemoteDto) _then;

/// Create a copy of SessionRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? annotatorId = null,Object? sessionType = null,Object? temperature = null,Object? wind = null,Object? sky = null,Object? rain = null,Object? visibility = null,Object? moon = null,Object? createdAt = null,Object? updatedAt = null,Object? isDeleted = null,Object? observations = null,Object? participants = null,Object? censusId = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? listeningPoint = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_SessionRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,annotatorId: null == annotatorId ? _self.annotatorId : annotatorId // ignore: cast_nullable_to_non_nullable
as String,sessionType: null == sessionType ? _self.sessionType : sessionType // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as int,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as int,sky: null == sky ? _self.sky : sky // ignore: cast_nullable_to_non_nullable
as int,rain: null == rain ? _self.rain : rain // ignore: cast_nullable_to_non_nullable
as int,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as int,moon: null == moon ? _self.moon : moon // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,observations: null == observations ? _self._observations : observations // ignore: cast_nullable_to_non_nullable
as List<ObservationRemoteDto>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ParticipantRemoteDto>,censusId: freezed == censusId ? _self.censusId : censusId // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningPoint: freezed == listeningPoint ? _self.listeningPoint : listeningPoint // ignore: cast_nullable_to_non_nullable
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
mixin _$ObservationRemoteDto {

 String get id; String get sessionId; String get speciesId; int get contactType; int get quantity; DateTime get startTime; DateTime get endTime; DateTime get createdAt; DateTime get updatedAt; double get bearing; bool get isDeleted; String? get notes; double? get latitude; double? get longitude; double? get accuracy; double? get altitude; double? get altitudeAccuracy; int? get locationSource;
/// Create a copy of ObservationRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObservationRemoteDtoCopyWith<ObservationRemoteDto> get copyWith => _$ObservationRemoteDtoCopyWithImpl<ObservationRemoteDto>(this as ObservationRemoteDto, _$identity);

  /// Serializes this ObservationRemoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObservationRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionId,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,isDeleted,notes,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource);

@override
String toString() {
  return 'ObservationRemoteDto(id: $id, sessionId: $sessionId, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, isDeleted: $isDeleted, notes: $notes, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class $ObservationRemoteDtoCopyWith<$Res>  {
  factory $ObservationRemoteDtoCopyWith(ObservationRemoteDto value, $Res Function(ObservationRemoteDto) _then) = _$ObservationRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String sessionId, String speciesId, int contactType, int quantity, DateTime startTime, DateTime endTime, DateTime createdAt, DateTime updatedAt, double bearing, bool isDeleted, String? notes, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class _$ObservationRemoteDtoCopyWithImpl<$Res>
    implements $ObservationRemoteDtoCopyWith<$Res> {
  _$ObservationRemoteDtoCopyWithImpl(this._self, this._then);

  final ObservationRemoteDto _self;
  final $Res Function(ObservationRemoteDto) _then;

/// Create a copy of ObservationRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? isDeleted = null,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ObservationRemoteDto].
extension ObservationRemoteDtoPatterns on ObservationRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObservationRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObservationRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObservationRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _ObservationRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObservationRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _ObservationRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sessionId,  String speciesId,  int contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  bool isDeleted,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObservationRemoteDto() when $default != null:
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.isDeleted,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sessionId,  String speciesId,  int contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  bool isDeleted,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)  $default,) {final _that = this;
switch (_that) {
case _ObservationRemoteDto():
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.isDeleted,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sessionId,  String speciesId,  int contactType,  int quantity,  DateTime startTime,  DateTime endTime,  DateTime createdAt,  DateTime updatedAt,  double bearing,  bool isDeleted,  String? notes,  double? latitude,  double? longitude,  double? accuracy,  double? altitude,  double? altitudeAccuracy,  int? locationSource)?  $default,) {final _that = this;
switch (_that) {
case _ObservationRemoteDto() when $default != null:
return $default(_that.id,_that.sessionId,_that.speciesId,_that.contactType,_that.quantity,_that.startTime,_that.endTime,_that.createdAt,_that.updatedAt,_that.bearing,_that.isDeleted,_that.notes,_that.latitude,_that.longitude,_that.accuracy,_that.altitude,_that.altitudeAccuracy,_that.locationSource);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ObservationRemoteDto implements ObservationRemoteDto {
  const _ObservationRemoteDto({required this.id, required this.sessionId, required this.speciesId, required this.contactType, required this.quantity, required this.startTime, required this.endTime, required this.createdAt, required this.updatedAt, required this.bearing, required this.isDeleted, this.notes, this.latitude, this.longitude, this.accuracy, this.altitude, this.altitudeAccuracy, this.locationSource});
  factory _ObservationRemoteDto.fromJson(Map<String, dynamic> json) => _$ObservationRemoteDtoFromJson(json);

@override final  String id;
@override final  String sessionId;
@override final  String speciesId;
@override final  int contactType;
@override final  int quantity;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  double bearing;
@override final  bool isDeleted;
@override final  String? notes;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  double? altitude;
@override final  double? altitudeAccuracy;
@override final  int? locationSource;

/// Create a copy of ObservationRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObservationRemoteDtoCopyWith<_ObservationRemoteDto> get copyWith => __$ObservationRemoteDtoCopyWithImpl<_ObservationRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ObservationRemoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObservationRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.contactType, contactType) || other.contactType == contactType)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bearing, bearing) || other.bearing == bearing)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.altitude, altitude) || other.altitude == altitude)&&(identical(other.altitudeAccuracy, altitudeAccuracy) || other.altitudeAccuracy == altitudeAccuracy)&&(identical(other.locationSource, locationSource) || other.locationSource == locationSource));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionId,speciesId,contactType,quantity,startTime,endTime,createdAt,updatedAt,bearing,isDeleted,notes,latitude,longitude,accuracy,altitude,altitudeAccuracy,locationSource);

@override
String toString() {
  return 'ObservationRemoteDto(id: $id, sessionId: $sessionId, speciesId: $speciesId, contactType: $contactType, quantity: $quantity, startTime: $startTime, endTime: $endTime, createdAt: $createdAt, updatedAt: $updatedAt, bearing: $bearing, isDeleted: $isDeleted, notes: $notes, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, altitudeAccuracy: $altitudeAccuracy, locationSource: $locationSource)';
}


}

/// @nodoc
abstract mixin class _$ObservationRemoteDtoCopyWith<$Res> implements $ObservationRemoteDtoCopyWith<$Res> {
  factory _$ObservationRemoteDtoCopyWith(_ObservationRemoteDto value, $Res Function(_ObservationRemoteDto) _then) = __$ObservationRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String sessionId, String speciesId, int contactType, int quantity, DateTime startTime, DateTime endTime, DateTime createdAt, DateTime updatedAt, double bearing, bool isDeleted, String? notes, double? latitude, double? longitude, double? accuracy, double? altitude, double? altitudeAccuracy, int? locationSource
});




}
/// @nodoc
class __$ObservationRemoteDtoCopyWithImpl<$Res>
    implements _$ObservationRemoteDtoCopyWith<$Res> {
  __$ObservationRemoteDtoCopyWithImpl(this._self, this._then);

  final _ObservationRemoteDto _self;
  final $Res Function(_ObservationRemoteDto) _then;

/// Create a copy of ObservationRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? speciesId = null,Object? contactType = null,Object? quantity = null,Object? startTime = null,Object? endTime = null,Object? createdAt = null,Object? updatedAt = null,Object? bearing = null,Object? isDeleted = null,Object? notes = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? altitude = freezed,Object? altitudeAccuracy = freezed,Object? locationSource = freezed,}) {
  return _then(_ObservationRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,contactType: null == contactType ? _self.contactType : contactType // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bearing: null == bearing ? _self.bearing : bearing // ignore: cast_nullable_to_non_nullable
as double,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
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
mixin _$ParticipantRemoteDto {

 String get sessionId; String get ornithologistCode;
/// Create a copy of ParticipantRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParticipantRemoteDtoCopyWith<ParticipantRemoteDto> get copyWith => _$ParticipantRemoteDtoCopyWithImpl<ParticipantRemoteDto>(this as ParticipantRemoteDto, _$identity);

  /// Serializes this ParticipantRemoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParticipantRemoteDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.ornithologistCode, ornithologistCode) || other.ornithologistCode == ornithologistCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,ornithologistCode);

@override
String toString() {
  return 'ParticipantRemoteDto(sessionId: $sessionId, ornithologistCode: $ornithologistCode)';
}


}

/// @nodoc
abstract mixin class $ParticipantRemoteDtoCopyWith<$Res>  {
  factory $ParticipantRemoteDtoCopyWith(ParticipantRemoteDto value, $Res Function(ParticipantRemoteDto) _then) = _$ParticipantRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String sessionId, String ornithologistCode
});




}
/// @nodoc
class _$ParticipantRemoteDtoCopyWithImpl<$Res>
    implements $ParticipantRemoteDtoCopyWith<$Res> {
  _$ParticipantRemoteDtoCopyWithImpl(this._self, this._then);

  final ParticipantRemoteDto _self;
  final $Res Function(ParticipantRemoteDto) _then;

/// Create a copy of ParticipantRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? ornithologistCode = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,ornithologistCode: null == ornithologistCode ? _self.ornithologistCode : ornithologistCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParticipantRemoteDto].
extension ParticipantRemoteDtoPatterns on ParticipantRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ParticipantRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ParticipantRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ParticipantRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _ParticipantRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ParticipantRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _ParticipantRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String ornithologistCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ParticipantRemoteDto() when $default != null:
return $default(_that.sessionId,_that.ornithologistCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String ornithologistCode)  $default,) {final _that = this;
switch (_that) {
case _ParticipantRemoteDto():
return $default(_that.sessionId,_that.ornithologistCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String ornithologistCode)?  $default,) {final _that = this;
switch (_that) {
case _ParticipantRemoteDto() when $default != null:
return $default(_that.sessionId,_that.ornithologistCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ParticipantRemoteDto implements ParticipantRemoteDto {
  const _ParticipantRemoteDto({required this.sessionId, required this.ornithologistCode});
  factory _ParticipantRemoteDto.fromJson(Map<String, dynamic> json) => _$ParticipantRemoteDtoFromJson(json);

@override final  String sessionId;
@override final  String ornithologistCode;

/// Create a copy of ParticipantRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ParticipantRemoteDtoCopyWith<_ParticipantRemoteDto> get copyWith => __$ParticipantRemoteDtoCopyWithImpl<_ParticipantRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParticipantRemoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ParticipantRemoteDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.ornithologistCode, ornithologistCode) || other.ornithologistCode == ornithologistCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,ornithologistCode);

@override
String toString() {
  return 'ParticipantRemoteDto(sessionId: $sessionId, ornithologistCode: $ornithologistCode)';
}


}

/// @nodoc
abstract mixin class _$ParticipantRemoteDtoCopyWith<$Res> implements $ParticipantRemoteDtoCopyWith<$Res> {
  factory _$ParticipantRemoteDtoCopyWith(_ParticipantRemoteDto value, $Res Function(_ParticipantRemoteDto) _then) = __$ParticipantRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String ornithologistCode
});




}
/// @nodoc
class __$ParticipantRemoteDtoCopyWithImpl<$Res>
    implements _$ParticipantRemoteDtoCopyWith<$Res> {
  __$ParticipantRemoteDtoCopyWithImpl(this._self, this._then);

  final _ParticipantRemoteDto _self;
  final $Res Function(_ParticipantRemoteDto) _then;

/// Create a copy of ParticipantRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? ornithologistCode = null,}) {
  return _then(_ParticipantRemoteDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,ornithologistCode: null == ornithologistCode ? _self.ornithologistCode : ornithologistCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
