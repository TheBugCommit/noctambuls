// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'refresh_token_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RefreshTokenResponseModel {

@JsonKey(name: 'token') String get accessToken;@JsonKey(name: 'refresh_token') String get refreshToken;
/// Create a copy of RefreshTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshTokenResponseModelCopyWith<RefreshTokenResponseModel> get copyWith => _$RefreshTokenResponseModelCopyWithImpl<RefreshTokenResponseModel>(this as RefreshTokenResponseModel, _$identity);

  /// Serializes this RefreshTokenResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshTokenResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'RefreshTokenResponseModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $RefreshTokenResponseModelCopyWith<$Res>  {
  factory $RefreshTokenResponseModelCopyWith(RefreshTokenResponseModel value, $Res Function(RefreshTokenResponseModel) _then) = _$RefreshTokenResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class _$RefreshTokenResponseModelCopyWithImpl<$Res>
    implements $RefreshTokenResponseModelCopyWith<$Res> {
  _$RefreshTokenResponseModelCopyWithImpl(this._self, this._then);

  final RefreshTokenResponseModel _self;
  final $Res Function(RefreshTokenResponseModel) _then;

/// Create a copy of RefreshTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshTokenResponseModel].
extension RefreshTokenResponseModelPatterns on RefreshTokenResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshTokenResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshTokenResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshTokenResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshTokenResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshTokenResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshTokenResponseModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenResponseModel():
return $default(_that.accessToken,_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _RefreshTokenResponseModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshTokenResponseModel implements RefreshTokenResponseModel {
  const _RefreshTokenResponseModel({@JsonKey(name: 'token') required this.accessToken, @JsonKey(name: 'refresh_token') required this.refreshToken});
  factory _RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseModelFromJson(json);

@override@JsonKey(name: 'token') final  String accessToken;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;

/// Create a copy of RefreshTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshTokenResponseModelCopyWith<_RefreshTokenResponseModel> get copyWith => __$RefreshTokenResponseModelCopyWithImpl<_RefreshTokenResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshTokenResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshTokenResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'RefreshTokenResponseModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$RefreshTokenResponseModelCopyWith<$Res> implements $RefreshTokenResponseModelCopyWith<$Res> {
  factory _$RefreshTokenResponseModelCopyWith(_RefreshTokenResponseModel value, $Res Function(_RefreshTokenResponseModel) _then) = __$RefreshTokenResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class __$RefreshTokenResponseModelCopyWithImpl<$Res>
    implements _$RefreshTokenResponseModelCopyWith<$Res> {
  __$RefreshTokenResponseModelCopyWithImpl(this._self, this._then);

  final _RefreshTokenResponseModel _self;
  final $Res Function(_RefreshTokenResponseModel) _then;

/// Create a copy of RefreshTokenResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_RefreshTokenResponseModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
