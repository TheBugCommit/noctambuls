// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignUpRequestModel {

@JsonKey(name: 'id_token') String get idToken; String get name; String get phone;
/// Create a copy of SignUpRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpRequestModelCopyWith<SignUpRequestModel> get copyWith => _$SignUpRequestModelCopyWithImpl<SignUpRequestModel>(this as SignUpRequestModel, _$identity);

  /// Serializes this SignUpRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpRequestModel&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,name,phone);

@override
String toString() {
  return 'SignUpRequestModel(idToken: $idToken, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class $SignUpRequestModelCopyWith<$Res>  {
  factory $SignUpRequestModelCopyWith(SignUpRequestModel value, $Res Function(SignUpRequestModel) _then) = _$SignUpRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id_token') String idToken, String name, String phone
});




}
/// @nodoc
class _$SignUpRequestModelCopyWithImpl<$Res>
    implements $SignUpRequestModelCopyWith<$Res> {
  _$SignUpRequestModelCopyWithImpl(this._self, this._then);

  final SignUpRequestModel _self;
  final $Res Function(SignUpRequestModel) _then;

/// Create a copy of SignUpRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = null,Object? name = null,Object? phone = null,}) {
  return _then(_self.copyWith(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpRequestModel].
extension SignUpRequestModelPatterns on SignUpRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _SignUpRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_token')  String idToken,  String name,  String phone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpRequestModel() when $default != null:
return $default(_that.idToken,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id_token')  String idToken,  String name,  String phone)  $default,) {final _that = this;
switch (_that) {
case _SignUpRequestModel():
return $default(_that.idToken,_that.name,_that.phone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id_token')  String idToken,  String name,  String phone)?  $default,) {final _that = this;
switch (_that) {
case _SignUpRequestModel() when $default != null:
return $default(_that.idToken,_that.name,_that.phone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignUpRequestModel implements SignUpRequestModel {
  const _SignUpRequestModel({@JsonKey(name: 'id_token') required this.idToken, required this.name, required this.phone});
  factory _SignUpRequestModel.fromJson(Map<String, dynamic> json) => _$SignUpRequestModelFromJson(json);

@override@JsonKey(name: 'id_token') final  String idToken;
@override final  String name;
@override final  String phone;

/// Create a copy of SignUpRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpRequestModelCopyWith<_SignUpRequestModel> get copyWith => __$SignUpRequestModelCopyWithImpl<_SignUpRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignUpRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpRequestModel&&(identical(other.idToken, idToken) || other.idToken == idToken)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken,name,phone);

@override
String toString() {
  return 'SignUpRequestModel(idToken: $idToken, name: $name, phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$SignUpRequestModelCopyWith<$Res> implements $SignUpRequestModelCopyWith<$Res> {
  factory _$SignUpRequestModelCopyWith(_SignUpRequestModel value, $Res Function(_SignUpRequestModel) _then) = __$SignUpRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id_token') String idToken, String name, String phone
});




}
/// @nodoc
class __$SignUpRequestModelCopyWithImpl<$Res>
    implements _$SignUpRequestModelCopyWith<$Res> {
  __$SignUpRequestModelCopyWithImpl(this._self, this._then);

  final _SignUpRequestModel _self;
  final $Res Function(_SignUpRequestModel) _then;

/// Create a copy of SignUpRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = null,Object? name = null,Object? phone = null,}) {
  return _then(_SignUpRequestModel(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
