// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'censuses_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CensusesResponseModel {

 List<CensusRemoteDto> get censuses; String get serverTime;
/// Create a copy of CensusesResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CensusesResponseModelCopyWith<CensusesResponseModel> get copyWith => _$CensusesResponseModelCopyWithImpl<CensusesResponseModel>(this as CensusesResponseModel, _$identity);

  /// Serializes this CensusesResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CensusesResponseModel&&const DeepCollectionEquality().equals(other.censuses, censuses)&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(censuses),serverTime);

@override
String toString() {
  return 'CensusesResponseModel(censuses: $censuses, serverTime: $serverTime)';
}


}

/// @nodoc
abstract mixin class $CensusesResponseModelCopyWith<$Res>  {
  factory $CensusesResponseModelCopyWith(CensusesResponseModel value, $Res Function(CensusesResponseModel) _then) = _$CensusesResponseModelCopyWithImpl;
@useResult
$Res call({
 List<CensusRemoteDto> censuses, String serverTime
});




}
/// @nodoc
class _$CensusesResponseModelCopyWithImpl<$Res>
    implements $CensusesResponseModelCopyWith<$Res> {
  _$CensusesResponseModelCopyWithImpl(this._self, this._then);

  final CensusesResponseModel _self;
  final $Res Function(CensusesResponseModel) _then;

/// Create a copy of CensusesResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? censuses = null,Object? serverTime = null,}) {
  return _then(_self.copyWith(
censuses: null == censuses ? _self.censuses : censuses // ignore: cast_nullable_to_non_nullable
as List<CensusRemoteDto>,serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CensusesResponseModel].
extension CensusesResponseModelPatterns on CensusesResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CensusesResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CensusesResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CensusesResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CensusesResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CensusesResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CensusesResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CensusRemoteDto> censuses,  String serverTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CensusesResponseModel() when $default != null:
return $default(_that.censuses,_that.serverTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CensusRemoteDto> censuses,  String serverTime)  $default,) {final _that = this;
switch (_that) {
case _CensusesResponseModel():
return $default(_that.censuses,_that.serverTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CensusRemoteDto> censuses,  String serverTime)?  $default,) {final _that = this;
switch (_that) {
case _CensusesResponseModel() when $default != null:
return $default(_that.censuses,_that.serverTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CensusesResponseModel implements CensusesResponseModel {
  const _CensusesResponseModel({required final  List<CensusRemoteDto> censuses, required this.serverTime}): _censuses = censuses;
  factory _CensusesResponseModel.fromJson(Map<String, dynamic> json) => _$CensusesResponseModelFromJson(json);

 final  List<CensusRemoteDto> _censuses;
@override List<CensusRemoteDto> get censuses {
  if (_censuses is EqualUnmodifiableListView) return _censuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_censuses);
}

@override final  String serverTime;

/// Create a copy of CensusesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CensusesResponseModelCopyWith<_CensusesResponseModel> get copyWith => __$CensusesResponseModelCopyWithImpl<_CensusesResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CensusesResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CensusesResponseModel&&const DeepCollectionEquality().equals(other._censuses, _censuses)&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_censuses),serverTime);

@override
String toString() {
  return 'CensusesResponseModel(censuses: $censuses, serverTime: $serverTime)';
}


}

/// @nodoc
abstract mixin class _$CensusesResponseModelCopyWith<$Res> implements $CensusesResponseModelCopyWith<$Res> {
  factory _$CensusesResponseModelCopyWith(_CensusesResponseModel value, $Res Function(_CensusesResponseModel) _then) = __$CensusesResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<CensusRemoteDto> censuses, String serverTime
});




}
/// @nodoc
class __$CensusesResponseModelCopyWithImpl<$Res>
    implements _$CensusesResponseModelCopyWith<$Res> {
  __$CensusesResponseModelCopyWithImpl(this._self, this._then);

  final _CensusesResponseModel _self;
  final $Res Function(_CensusesResponseModel) _then;

/// Create a copy of CensusesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? censuses = null,Object? serverTime = null,}) {
  return _then(_CensusesResponseModel(
censuses: null == censuses ? _self._censuses : censuses // ignore: cast_nullable_to_non_nullable
as List<CensusRemoteDto>,serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CensusRemoteDto {

 String get id; String get title; String get date; String get time; String get updatedAt; double? get latitude; double? get longitude; String? get locationName; String? get description;
/// Create a copy of CensusRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CensusRemoteDtoCopyWith<CensusRemoteDto> get copyWith => _$CensusRemoteDtoCopyWithImpl<CensusRemoteDto>(this as CensusRemoteDto, _$identity);

  /// Serializes this CensusRemoteDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CensusRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,time,updatedAt,latitude,longitude,locationName,description);

@override
String toString() {
  return 'CensusRemoteDto(id: $id, title: $title, date: $date, time: $time, updatedAt: $updatedAt, latitude: $latitude, longitude: $longitude, locationName: $locationName, description: $description)';
}


}

/// @nodoc
abstract mixin class $CensusRemoteDtoCopyWith<$Res>  {
  factory $CensusRemoteDtoCopyWith(CensusRemoteDto value, $Res Function(CensusRemoteDto) _then) = _$CensusRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String date, String time, String updatedAt, double? latitude, double? longitude, String? locationName, String? description
});




}
/// @nodoc
class _$CensusRemoteDtoCopyWithImpl<$Res>
    implements $CensusRemoteDtoCopyWith<$Res> {
  _$CensusRemoteDtoCopyWithImpl(this._self, this._then);

  final CensusRemoteDto _self;
  final $Res Function(CensusRemoteDto) _then;

/// Create a copy of CensusRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? date = null,Object? time = null,Object? updatedAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CensusRemoteDto].
extension CensusRemoteDtoPatterns on CensusRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CensusRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CensusRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CensusRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _CensusRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CensusRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _CensusRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String date,  String time,  String updatedAt,  double? latitude,  double? longitude,  String? locationName,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CensusRemoteDto() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.time,_that.updatedAt,_that.latitude,_that.longitude,_that.locationName,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String date,  String time,  String updatedAt,  double? latitude,  double? longitude,  String? locationName,  String? description)  $default,) {final _that = this;
switch (_that) {
case _CensusRemoteDto():
return $default(_that.id,_that.title,_that.date,_that.time,_that.updatedAt,_that.latitude,_that.longitude,_that.locationName,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String date,  String time,  String updatedAt,  double? latitude,  double? longitude,  String? locationName,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _CensusRemoteDto() when $default != null:
return $default(_that.id,_that.title,_that.date,_that.time,_that.updatedAt,_that.latitude,_that.longitude,_that.locationName,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CensusRemoteDto implements CensusRemoteDto {
  const _CensusRemoteDto({required this.id, required this.title, required this.date, required this.time, required this.updatedAt, this.latitude, this.longitude, this.locationName, this.description});
  factory _CensusRemoteDto.fromJson(Map<String, dynamic> json) => _$CensusRemoteDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String date;
@override final  String time;
@override final  String updatedAt;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? locationName;
@override final  String? description;

/// Create a copy of CensusRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CensusRemoteDtoCopyWith<_CensusRemoteDto> get copyWith => __$CensusRemoteDtoCopyWithImpl<_CensusRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CensusRemoteDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CensusRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,date,time,updatedAt,latitude,longitude,locationName,description);

@override
String toString() {
  return 'CensusRemoteDto(id: $id, title: $title, date: $date, time: $time, updatedAt: $updatedAt, latitude: $latitude, longitude: $longitude, locationName: $locationName, description: $description)';
}


}

/// @nodoc
abstract mixin class _$CensusRemoteDtoCopyWith<$Res> implements $CensusRemoteDtoCopyWith<$Res> {
  factory _$CensusRemoteDtoCopyWith(_CensusRemoteDto value, $Res Function(_CensusRemoteDto) _then) = __$CensusRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String date, String time, String updatedAt, double? latitude, double? longitude, String? locationName, String? description
});




}
/// @nodoc
class __$CensusRemoteDtoCopyWithImpl<$Res>
    implements _$CensusRemoteDtoCopyWith<$Res> {
  __$CensusRemoteDtoCopyWithImpl(this._self, this._then);

  final _CensusRemoteDto _self;
  final $Res Function(_CensusRemoteDto) _then;

/// Create a copy of CensusRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? date = null,Object? time = null,Object? updatedAt = null,Object? latitude = freezed,Object? longitude = freezed,Object? locationName = freezed,Object? description = freezed,}) {
  return _then(_CensusRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
