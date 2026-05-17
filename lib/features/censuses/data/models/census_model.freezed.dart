// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'census_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CensusModel {

 String get id; String get title; DateTime get startTime; DateTime get createdAt; DateTime get updatedAt; String? get locationName; String? get description; GeoPosition? get geoPosition; bool get isJoined; bool get alreadyDone; bool get isDeleted;
/// Create a copy of CensusModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CensusModelCopyWith<CensusModel> get copyWith => _$CensusModelCopyWithImpl<CensusModel>(this as CensusModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CensusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.description, description) || other.description == description)&&(identical(other.geoPosition, geoPosition) || other.geoPosition == geoPosition)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.alreadyDone, alreadyDone) || other.alreadyDone == alreadyDone)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startTime,createdAt,updatedAt,locationName,description,geoPosition,isJoined,alreadyDone,isDeleted);

@override
String toString() {
  return 'CensusModel(id: $id, title: $title, startTime: $startTime, createdAt: $createdAt, updatedAt: $updatedAt, locationName: $locationName, description: $description, geoPosition: $geoPosition, isJoined: $isJoined, alreadyDone: $alreadyDone, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $CensusModelCopyWith<$Res>  {
  factory $CensusModelCopyWith(CensusModel value, $Res Function(CensusModel) _then) = _$CensusModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime startTime, DateTime createdAt, DateTime updatedAt, String? locationName, String? description, GeoPosition? geoPosition, bool isJoined, bool alreadyDone, bool isDeleted
});




}
/// @nodoc
class _$CensusModelCopyWithImpl<$Res>
    implements $CensusModelCopyWith<$Res> {
  _$CensusModelCopyWithImpl(this._self, this._then);

  final CensusModel _self;
  final $Res Function(CensusModel) _then;

/// Create a copy of CensusModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startTime = null,Object? createdAt = null,Object? updatedAt = null,Object? locationName = freezed,Object? description = freezed,Object? geoPosition = freezed,Object? isJoined = null,Object? alreadyDone = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,geoPosition: freezed == geoPosition ? _self.geoPosition : geoPosition // ignore: cast_nullable_to_non_nullable
as GeoPosition?,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,alreadyDone: null == alreadyDone ? _self.alreadyDone : alreadyDone // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CensusModel].
extension CensusModelPatterns on CensusModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CensusModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CensusModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CensusModel value)  $default,){
final _that = this;
switch (_that) {
case _CensusModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CensusModel value)?  $default,){
final _that = this;
switch (_that) {
case _CensusModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startTime,  DateTime createdAt,  DateTime updatedAt,  String? locationName,  String? description,  GeoPosition? geoPosition,  bool isJoined,  bool alreadyDone,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CensusModel() when $default != null:
return $default(_that.id,_that.title,_that.startTime,_that.createdAt,_that.updatedAt,_that.locationName,_that.description,_that.geoPosition,_that.isJoined,_that.alreadyDone,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime startTime,  DateTime createdAt,  DateTime updatedAt,  String? locationName,  String? description,  GeoPosition? geoPosition,  bool isJoined,  bool alreadyDone,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _CensusModel():
return $default(_that.id,_that.title,_that.startTime,_that.createdAt,_that.updatedAt,_that.locationName,_that.description,_that.geoPosition,_that.isJoined,_that.alreadyDone,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime startTime,  DateTime createdAt,  DateTime updatedAt,  String? locationName,  String? description,  GeoPosition? geoPosition,  bool isJoined,  bool alreadyDone,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _CensusModel() when $default != null:
return $default(_that.id,_that.title,_that.startTime,_that.createdAt,_that.updatedAt,_that.locationName,_that.description,_that.geoPosition,_that.isJoined,_that.alreadyDone,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc


class _CensusModel implements CensusModel {
  const _CensusModel({required this.id, required this.title, required this.startTime, required this.createdAt, required this.updatedAt, this.locationName, this.description, this.geoPosition, this.isJoined = false, this.alreadyDone = false, this.isDeleted = false});
  

@override final  String id;
@override final  String title;
@override final  DateTime startTime;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? locationName;
@override final  String? description;
@override final  GeoPosition? geoPosition;
@override@JsonKey() final  bool isJoined;
@override@JsonKey() final  bool alreadyDone;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of CensusModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CensusModelCopyWith<_CensusModel> get copyWith => __$CensusModelCopyWithImpl<_CensusModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CensusModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.locationName, locationName) || other.locationName == locationName)&&(identical(other.description, description) || other.description == description)&&(identical(other.geoPosition, geoPosition) || other.geoPosition == geoPosition)&&(identical(other.isJoined, isJoined) || other.isJoined == isJoined)&&(identical(other.alreadyDone, alreadyDone) || other.alreadyDone == alreadyDone)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,startTime,createdAt,updatedAt,locationName,description,geoPosition,isJoined,alreadyDone,isDeleted);

@override
String toString() {
  return 'CensusModel(id: $id, title: $title, startTime: $startTime, createdAt: $createdAt, updatedAt: $updatedAt, locationName: $locationName, description: $description, geoPosition: $geoPosition, isJoined: $isJoined, alreadyDone: $alreadyDone, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$CensusModelCopyWith<$Res> implements $CensusModelCopyWith<$Res> {
  factory _$CensusModelCopyWith(_CensusModel value, $Res Function(_CensusModel) _then) = __$CensusModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime startTime, DateTime createdAt, DateTime updatedAt, String? locationName, String? description, GeoPosition? geoPosition, bool isJoined, bool alreadyDone, bool isDeleted
});




}
/// @nodoc
class __$CensusModelCopyWithImpl<$Res>
    implements _$CensusModelCopyWith<$Res> {
  __$CensusModelCopyWithImpl(this._self, this._then);

  final _CensusModel _self;
  final $Res Function(_CensusModel) _then;

/// Create a copy of CensusModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startTime = null,Object? createdAt = null,Object? updatedAt = null,Object? locationName = freezed,Object? description = freezed,Object? geoPosition = freezed,Object? isJoined = null,Object? alreadyDone = null,Object? isDeleted = null,}) {
  return _then(_CensusModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,locationName: freezed == locationName ? _self.locationName : locationName // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,geoPosition: freezed == geoPosition ? _self.geoPosition : geoPosition // ignore: cast_nullable_to_non_nullable
as GeoPosition?,isJoined: null == isJoined ? _self.isJoined : isJoined // ignore: cast_nullable_to_non_nullable
as bool,alreadyDone: null == alreadyDone ? _self.alreadyDone : alreadyDone // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
