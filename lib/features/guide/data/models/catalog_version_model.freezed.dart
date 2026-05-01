// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_version_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogVersionModel {

@JsonKey(fromJson: _versionFromJson) String get version; DateTime get lastUpdatedAt;
/// Create a copy of CatalogVersionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogVersionModelCopyWith<CatalogVersionModel> get copyWith => _$CatalogVersionModelCopyWithImpl<CatalogVersionModel>(this as CatalogVersionModel, _$identity);

  /// Serializes this CatalogVersionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogVersionModel&&(identical(other.version, version) || other.version == version)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,lastUpdatedAt);

@override
String toString() {
  return 'CatalogVersionModel(version: $version, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class $CatalogVersionModelCopyWith<$Res>  {
  factory $CatalogVersionModelCopyWith(CatalogVersionModel value, $Res Function(CatalogVersionModel) _then) = _$CatalogVersionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _versionFromJson) String version, DateTime lastUpdatedAt
});




}
/// @nodoc
class _$CatalogVersionModelCopyWithImpl<$Res>
    implements $CatalogVersionModelCopyWith<$Res> {
  _$CatalogVersionModelCopyWithImpl(this._self, this._then);

  final CatalogVersionModel _self;
  final $Res Function(CatalogVersionModel) _then;

/// Create a copy of CatalogVersionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? lastUpdatedAt = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogVersionModel].
extension CatalogVersionModelPatterns on CatalogVersionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogVersionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogVersionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogVersionModel value)  $default,){
final _that = this;
switch (_that) {
case _CatalogVersionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogVersionModel value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogVersionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _versionFromJson)  String version,  DateTime lastUpdatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogVersionModel() when $default != null:
return $default(_that.version,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _versionFromJson)  String version,  DateTime lastUpdatedAt)  $default,) {final _that = this;
switch (_that) {
case _CatalogVersionModel():
return $default(_that.version,_that.lastUpdatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _versionFromJson)  String version,  DateTime lastUpdatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CatalogVersionModel() when $default != null:
return $default(_that.version,_that.lastUpdatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogVersionModel implements CatalogVersionModel {
  const _CatalogVersionModel({@JsonKey(fromJson: _versionFromJson) required this.version, required this.lastUpdatedAt});
  factory _CatalogVersionModel.fromJson(Map<String, dynamic> json) => _$CatalogVersionModelFromJson(json);

@override@JsonKey(fromJson: _versionFromJson) final  String version;
@override final  DateTime lastUpdatedAt;

/// Create a copy of CatalogVersionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogVersionModelCopyWith<_CatalogVersionModel> get copyWith => __$CatalogVersionModelCopyWithImpl<_CatalogVersionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogVersionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogVersionModel&&(identical(other.version, version) || other.version == version)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,lastUpdatedAt);

@override
String toString() {
  return 'CatalogVersionModel(version: $version, lastUpdatedAt: $lastUpdatedAt)';
}


}

/// @nodoc
abstract mixin class _$CatalogVersionModelCopyWith<$Res> implements $CatalogVersionModelCopyWith<$Res> {
  factory _$CatalogVersionModelCopyWith(_CatalogVersionModel value, $Res Function(_CatalogVersionModel) _then) = __$CatalogVersionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _versionFromJson) String version, DateTime lastUpdatedAt
});




}
/// @nodoc
class __$CatalogVersionModelCopyWithImpl<$Res>
    implements _$CatalogVersionModelCopyWith<$Res> {
  __$CatalogVersionModelCopyWithImpl(this._self, this._then);

  final _CatalogVersionModel _self;
  final $Res Function(_CatalogVersionModel) _then;

/// Create a copy of CatalogVersionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? lastUpdatedAt = null,}) {
  return _then(_CatalogVersionModel(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,lastUpdatedAt: null == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
