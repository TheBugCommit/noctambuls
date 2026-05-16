// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_bubble_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapBubbleModel {

 String get id; String get speciesId; double get lat; double get lon; int get year; int get count; DateTime get updatedAt;
/// Create a copy of MapBubbleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapBubbleModelCopyWith<MapBubbleModel> get copyWith => _$MapBubbleModelCopyWithImpl<MapBubbleModel>(this as MapBubbleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapBubbleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,speciesId,lat,lon,year,count,updatedAt);

@override
String toString() {
  return 'MapBubbleModel(id: $id, speciesId: $speciesId, lat: $lat, lon: $lon, year: $year, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MapBubbleModelCopyWith<$Res>  {
  factory $MapBubbleModelCopyWith(MapBubbleModel value, $Res Function(MapBubbleModel) _then) = _$MapBubbleModelCopyWithImpl;
@useResult
$Res call({
 String id, String speciesId, double lat, double lon, int year, int count, DateTime updatedAt
});




}
/// @nodoc
class _$MapBubbleModelCopyWithImpl<$Res>
    implements $MapBubbleModelCopyWith<$Res> {
  _$MapBubbleModelCopyWithImpl(this._self, this._then);

  final MapBubbleModel _self;
  final $Res Function(MapBubbleModel) _then;

/// Create a copy of MapBubbleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? speciesId = null,Object? lat = null,Object? lon = null,Object? year = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MapBubbleModel].
extension MapBubbleModelPatterns on MapBubbleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapBubbleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapBubbleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapBubbleModel value)  $default,){
final _that = this;
switch (_that) {
case _MapBubbleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapBubbleModel value)?  $default,){
final _that = this;
switch (_that) {
case _MapBubbleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String speciesId,  double lat,  double lon,  int year,  int count,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapBubbleModel() when $default != null:
return $default(_that.id,_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String speciesId,  double lat,  double lon,  int year,  int count,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MapBubbleModel():
return $default(_that.id,_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String speciesId,  double lat,  double lon,  int year,  int count,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MapBubbleModel() when $default != null:
return $default(_that.id,_that.speciesId,_that.lat,_that.lon,_that.year,_that.count,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MapBubbleModel implements MapBubbleModel {
  const _MapBubbleModel({required this.id, required this.speciesId, required this.lat, required this.lon, required this.year, required this.count, required this.updatedAt});
  

@override final  String id;
@override final  String speciesId;
@override final  double lat;
@override final  double lon;
@override final  int year;
@override final  int count;
@override final  DateTime updatedAt;

/// Create a copy of MapBubbleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapBubbleModelCopyWith<_MapBubbleModel> get copyWith => __$MapBubbleModelCopyWithImpl<_MapBubbleModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapBubbleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.speciesId, speciesId) || other.speciesId == speciesId)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.year, year) || other.year == year)&&(identical(other.count, count) || other.count == count)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,speciesId,lat,lon,year,count,updatedAt);

@override
String toString() {
  return 'MapBubbleModel(id: $id, speciesId: $speciesId, lat: $lat, lon: $lon, year: $year, count: $count, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MapBubbleModelCopyWith<$Res> implements $MapBubbleModelCopyWith<$Res> {
  factory _$MapBubbleModelCopyWith(_MapBubbleModel value, $Res Function(_MapBubbleModel) _then) = __$MapBubbleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String speciesId, double lat, double lon, int year, int count, DateTime updatedAt
});




}
/// @nodoc
class __$MapBubbleModelCopyWithImpl<$Res>
    implements _$MapBubbleModelCopyWith<$Res> {
  __$MapBubbleModelCopyWithImpl(this._self, this._then);

  final _MapBubbleModel _self;
  final $Res Function(_MapBubbleModel) _then;

/// Create a copy of MapBubbleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? speciesId = null,Object? lat = null,Object? lon = null,Object? year = null,Object? count = null,Object? updatedAt = null,}) {
  return _then(_MapBubbleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,speciesId: null == speciesId ? _self.speciesId : speciesId // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
