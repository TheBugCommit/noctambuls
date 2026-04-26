// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RefreshTokenRequestModel {

@JsonKey(name: 'refresh_token') String get refreshToken;
/// Create a copy of RefreshTokenRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshTokenRequestModelCopyWith<RefreshTokenRequestModel> get copyWith => _$RefreshTokenRequestModelCopyWithImpl<RefreshTokenRequestModel>(this as RefreshTokenRequestModel, _$identity);

  /// Serializes this RefreshTokenRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTokenRequestModel&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshTokenRequestModel(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $RefreshTokenRequestModelCopyWith<$Res>  {
  factory $RefreshTokenRequestModelCopyWith(RefreshTokenRequestModel value, $Res Function(RefreshTokenRequestModel) _then) = _$RefreshTokenRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class _$RefreshTokenRequestModelCopyWithImpl<$Res>
    implements $RefreshTokenRequestModelCopyWith<$Res> {
  _$RefreshTokenRequestModelCopyWithImpl(this._self, this._then);

  final RefreshTokenRequestModel _self;
  final $Res Function(RefreshTokenRequestModel) _then;

/// Create a copy of RefreshTokenRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshToken = null,}) {
  return _then(_self.copyWith(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshTokenRequestModel].
extension RefreshTokenRequestModelPatterns on RefreshTokenRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshTokenRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshTokenRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshTokenRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshTokenRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshTokenRequestModel() when $default != null:
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'refresh_token')  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenRequestModel():
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'refresh_token')  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenRequestModel() when $default != null:
return $default(_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshTokenRequestModel implements RefreshTokenRequestModel {
  const _RefreshTokenRequestModel({@JsonKey(name: 'refresh_token') required this.refreshToken});
  factory _RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestModelFromJson(json);

@override@JsonKey(name: 'refresh_token') final  String refreshToken;

/// Create a copy of RefreshTokenRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshTokenRequestModelCopyWith<_RefreshTokenRequestModel> get copyWith => __$RefreshTokenRequestModelCopyWithImpl<_RefreshTokenRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshTokenRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTokenRequestModel&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshTokenRequestModel(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$RefreshTokenRequestModelCopyWith<$Res> implements $RefreshTokenRequestModelCopyWith<$Res> {
  factory _$RefreshTokenRequestModelCopyWith(_RefreshTokenRequestModel value, $Res Function(_RefreshTokenRequestModel) _then) = __$RefreshTokenRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class __$RefreshTokenRequestModelCopyWithImpl<$Res>
    implements _$RefreshTokenRequestModelCopyWith<$Res> {
  __$RefreshTokenRequestModelCopyWithImpl(this._self, this._then);

  final _RefreshTokenRequestModel _self;
  final $Res Function(_RefreshTokenRequestModel) _then;

/// Create a copy of RefreshTokenRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshToken = null,}) {
  return _then(_RefreshTokenRequestModel(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
