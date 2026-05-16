// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_bubbles_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapBubblesResponseModel {

 String get serverTime; List<MapBubbleDto> get items;
/// Create a copy of MapBubblesResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapBubblesResponseModelCopyWith<MapBubblesResponseModel> get copyWith => _$MapBubblesResponseModelCopyWithImpl<MapBubblesResponseModel>(this as MapBubblesResponseModel, _$identity);

  /// Serializes this MapBubblesResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapBubblesResponseModel&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverTime,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'MapBubblesResponseModel(serverTime: $serverTime, items: $items)';
}


}

/// @nodoc
abstract mixin class $MapBubblesResponseModelCopyWith<$Res>  {
  factory $MapBubblesResponseModelCopyWith(MapBubblesResponseModel value, $Res Function(MapBubblesResponseModel) _then) = _$MapBubblesResponseModelCopyWithImpl;
@useResult
$Res call({
 String serverTime, List<MapBubbleDto> items
});




}
/// @nodoc
class _$MapBubblesResponseModelCopyWithImpl<$Res>
    implements $MapBubblesResponseModelCopyWith<$Res> {
  _$MapBubblesResponseModelCopyWithImpl(this._self, this._then);

  final MapBubblesResponseModel _self;
  final $Res Function(MapBubblesResponseModel) _then;

/// Create a copy of MapBubblesResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverTime = null,Object? items = null,}) {
  return _then(_self.copyWith(
serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MapBubbleDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapBubblesResponseModel].
extension MapBubblesResponseModelPatterns on MapBubblesResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapBubblesResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapBubblesResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapBubblesResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _MapBubblesResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapBubblesResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _MapBubblesResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverTime,  List<MapBubbleDto> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapBubblesResponseModel() when $default != null:
return $default(_that.serverTime,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverTime,  List<MapBubbleDto> items)  $default,) {final _that = this;
switch (_that) {
case _MapBubblesResponseModel():
return $default(_that.serverTime,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverTime,  List<MapBubbleDto> items)?  $default,) {final _that = this;
switch (_that) {
case _MapBubblesResponseModel() when $default != null:
return $default(_that.serverTime,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapBubblesResponseModel implements MapBubblesResponseModel {
  const _MapBubblesResponseModel({required this.serverTime, required final  List<MapBubbleDto> items}): _items = items;
  factory _MapBubblesResponseModel.fromJson(Map<String, dynamic> json) => _$MapBubblesResponseModelFromJson(json);

@override final  String serverTime;
 final  List<MapBubbleDto> _items;
@override List<MapBubbleDto> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of MapBubblesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapBubblesResponseModelCopyWith<_MapBubblesResponseModel> get copyWith => __$MapBubblesResponseModelCopyWithImpl<_MapBubblesResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapBubblesResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapBubblesResponseModel&&(identical(other.serverTime, serverTime) || other.serverTime == serverTime)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serverTime,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'MapBubblesResponseModel(serverTime: $serverTime, items: $items)';
}


}

/// @nodoc
abstract mixin class _$MapBubblesResponseModelCopyWith<$Res> implements $MapBubblesResponseModelCopyWith<$Res> {
  factory _$MapBubblesResponseModelCopyWith(_MapBubblesResponseModel value, $Res Function(_MapBubblesResponseModel) _then) = __$MapBubblesResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String serverTime, List<MapBubbleDto> items
});




}
/// @nodoc
class __$MapBubblesResponseModelCopyWithImpl<$Res>
    implements _$MapBubblesResponseModelCopyWith<$Res> {
  __$MapBubblesResponseModelCopyWithImpl(this._self, this._then);

  final _MapBubblesResponseModel _self;
  final $Res Function(_MapBubblesResponseModel) _then;

/// Create a copy of MapBubblesResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverTime = null,Object? items = null,}) {
  return _then(_MapBubblesResponseModel(
serverTime: null == serverTime ? _self.serverTime : serverTime // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MapBubbleDto>,
  ));
}


}


/// @nodoc
mixin _$MapBubbleDto {

@JsonKey(name: 'species_id') String get speciesId; double get lat; double get lon; int get year; int get count;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of MapBubbleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapBubbleDtoCopyWith<MapBubbleDto> get copyWith => _$MapBubbleDtoCopyWithImpl<MapBubbleDto>(this as MapBubbleDto, _$identity);

  /// Serializes this MapBubbleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapBubbleDto&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,lat,lon,year,count,updatedAt);

@override
String toString() {
  return 'MapBubbleDto(speciesId: $speciesId, lat: $lat, lon: $lon, year: $year, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MapBubbleDtoCopyWith<$Res>  {
  factory $MapBubbleDtoCopyWith(MapBubbleDto value, $Res Function(MapBubbleDto) _then) = _$MapBubbleDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'species_id') String speciesId, double lat, double lon, int year, int count,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$MapBubbleDtoCopyWithImpl<$Res>
    implements $MapBubbleDtoCopyWith<$Res> {
  _$MapBubbleDtoCopyWithImpl(this._self, this._then);

  final MapBubbleDto _self;
  final $Res Function(MapBubbleDto) _then;

/// Create a copy of MapBubbleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speciesId = null,Object? lat = null,Object? lon = null,Object? year = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MapBubbleDto].
extension MapBubbleDtoPatterns on MapBubbleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapBubbleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapBubbleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapBubbleDto value)  $default,){
final _that = this;
switch (_that) {
case _MapBubbleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapBubbleDto value)?  $default,){
final _that = this;
switch (_that) {
case _MapBubbleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'species_id')  String speciesId,  double lat,  double lon,  int year,  int count, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapBubbleDto() when $default != null:
return $default(_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'species_id')  String speciesId,  double lat,  double lon,  int year,  int count, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MapBubbleDto():
return $default(_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'species_id')  String speciesId,  double lat,  double lon,  int year,  int count, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MapBubbleDto() when $default != null:
return $default(_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MapBubbleDto implements MapBubbleDto {
  const _MapBubbleDto({@JsonKey(name: 'species_id') required this.speciesId, required this.lat, required this.lon, required this.year, required this.count, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _MapBubbleDto.fromJson(Map<String, dynamic> json) => _$MapBubbleDtoFromJson(json);

@override@JsonKey(name: 'species_id') final  String speciesId;
@override final  double lat;
@override final  double lon;
@override final  int year;
@override final  int count;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of MapBubbleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapBubbleDtoCopyWith<_MapBubbleDto> get copyWith => __$MapBubbleDtoCopyWithImpl<_MapBubbleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MapBubbleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapBubbleDto&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speciesId,lat,lon,year,count,updatedAt);

@override
String toString() {
  return 'MapBubbleDto(speciesId: $speciesId, lat: $lat, lon: $lon, year: $year, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MapBubbleDtoCopyWith<$Res> implements $MapBubbleDtoCopyWith<$Res> {
  factory _$MapBubbleDtoCopyWith(_MapBubbleDto value, $Res Function(_MapBubbleDto) _then) = __$MapBubbleDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'species_id') String speciesId, double lat, double lon, int year, int count,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$MapBubbleDtoCopyWithImpl<$Res>
    implements _$MapBubbleDtoCopyWith<$Res> {
  __$MapBubbleDtoCopyWithImpl(this._self, this._then);

  final _MapBubbleDto _self;
  final $Res Function(_MapBubbleDto) _then;

/// Create a copy of MapBubbleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speciesId = null,Object? lat = null,Object? lon = null,Object? year = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_MapBubbleDto(
speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
