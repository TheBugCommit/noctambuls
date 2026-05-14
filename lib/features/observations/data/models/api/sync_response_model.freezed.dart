// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncResponseModel {

 List<String> get synced; List<SyncFailedDto> get failed;
/// Create a copy of SyncResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncResponseModelCopyWith<SyncResponseModel> get copyWith => _$SyncResponseModelCopyWithImpl<SyncResponseModel>(this as SyncResponseModel, _$identity);

  /// Serializes this SyncResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncResponseModel&&const DeepCollectionEquality().equals(other.synced, synced)&&const DeepCollectionEquality().equals(other.failed, failed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(synced),const DeepCollectionEquality().hash(failed));

@override
String toString() {
  return 'SyncResponseModel(synced: $synced, failed: $failed)';
}


}

/// @nodoc
abstract mixin class $SyncResponseModelCopyWith<$Res>  {
  factory $SyncResponseModelCopyWith(SyncResponseModel value, $Res Function(SyncResponseModel) _then) = _$SyncResponseModelCopyWithImpl;
@useResult
$Res call({
 List<String> synced, List<SyncFailedDto> failed
});




}
/// @nodoc
class _$SyncResponseModelCopyWithImpl<$Res>
    implements $SyncResponseModelCopyWith<$Res> {
  _$SyncResponseModelCopyWithImpl(this._self, this._then);

  final SyncResponseModel _self;
  final $Res Function(SyncResponseModel) _then;

/// Create a copy of SyncResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? synced = null,Object? failed = null,}) {
  return _then(_self.copyWith(
synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as List<String>,failed: null == failed ? _self.failed : failed // ignore: cast_nullable_to_non_nullable
as List<SyncFailedDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncResponseModel].
extension SyncResponseModelPatterns on SyncResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SyncResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SyncResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> synced,  List<SyncFailedDto> failed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncResponseModel() when $default != null:
return $default(_that.synced,_that.failed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> synced,  List<SyncFailedDto> failed)  $default,) {final _that = this;
switch (_that) {
case _SyncResponseModel():
return $default(_that.synced,_that.failed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> synced,  List<SyncFailedDto> failed)?  $default,) {final _that = this;
switch (_that) {
case _SyncResponseModel() when $default != null:
return $default(_that.synced,_that.failed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncResponseModel implements SyncResponseModel {
  const _SyncResponseModel({required final  List<String> synced, required final  List<SyncFailedDto> failed}): _synced = synced,_failed = failed;
  factory _SyncResponseModel.fromJson(Map<String, dynamic> json) => _$SyncResponseModelFromJson(json);

 final  List<String> _synced;
@override List<String> get synced {
  if (_synced is EqualUnmodifiableListView) return _synced;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_synced);
}

 final  List<SyncFailedDto> _failed;
@override List<SyncFailedDto> get failed {
  if (_failed is EqualUnmodifiableListView) return _failed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_failed);
}


/// Create a copy of SyncResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncResponseModelCopyWith<_SyncResponseModel> get copyWith => __$SyncResponseModelCopyWithImpl<_SyncResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncResponseModel&&const DeepCollectionEquality().equals(other._synced, _synced)&&const DeepCollectionEquality().equals(other._failed, _failed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_synced),const DeepCollectionEquality().hash(_failed));

@override
String toString() {
  return 'SyncResponseModel(synced: $synced, failed: $failed)';
}


}

/// @nodoc
abstract mixin class _$SyncResponseModelCopyWith<$Res> implements $SyncResponseModelCopyWith<$Res> {
  factory _$SyncResponseModelCopyWith(_SyncResponseModel value, $Res Function(_SyncResponseModel) _then) = __$SyncResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> synced, List<SyncFailedDto> failed
});




}
/// @nodoc
class __$SyncResponseModelCopyWithImpl<$Res>
    implements _$SyncResponseModelCopyWith<$Res> {
  __$SyncResponseModelCopyWithImpl(this._self, this._then);

  final _SyncResponseModel _self;
  final $Res Function(_SyncResponseModel) _then;

/// Create a copy of SyncResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? synced = null,Object? failed = null,}) {
  return _then(_SyncResponseModel(
synced: null == synced ? _self._synced : synced // ignore: cast_nullable_to_non_nullable
as List<String>,failed: null == failed ? _self._failed : failed // ignore: cast_nullable_to_non_nullable
as List<SyncFailedDto>,
  ));
}


}


/// @nodoc
mixin _$SyncFailedDto {

 String get sessionId; String get reason;
/// Create a copy of SyncFailedDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncFailedDtoCopyWith<SyncFailedDto> get copyWith => _$SyncFailedDtoCopyWithImpl<SyncFailedDto>(this as SyncFailedDto, _$identity);

  /// Serializes this SyncFailedDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncFailedDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,reason);

@override
String toString() {
  return 'SyncFailedDto(sessionId: $sessionId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $SyncFailedDtoCopyWith<$Res>  {
  factory $SyncFailedDtoCopyWith(SyncFailedDto value, $Res Function(SyncFailedDto) _then) = _$SyncFailedDtoCopyWithImpl;
@useResult
$Res call({
 String sessionId, String reason
});




}
/// @nodoc
class _$SyncFailedDtoCopyWithImpl<$Res>
    implements $SyncFailedDtoCopyWith<$Res> {
  _$SyncFailedDtoCopyWithImpl(this._self, this._then);

  final SyncFailedDto _self;
  final $Res Function(SyncFailedDto) _then;

/// Create a copy of SyncFailedDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? reason = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncFailedDto].
extension SyncFailedDtoPatterns on SyncFailedDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncFailedDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncFailedDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncFailedDto value)  $default,){
final _that = this;
switch (_that) {
case _SyncFailedDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncFailedDto value)?  $default,){
final _that = this;
switch (_that) {
case _SyncFailedDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncFailedDto() when $default != null:
return $default(_that.sessionId,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String reason)  $default,) {final _that = this;
switch (_that) {
case _SyncFailedDto():
return $default(_that.sessionId,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _SyncFailedDto() when $default != null:
return $default(_that.sessionId,_that.reason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncFailedDto implements SyncFailedDto {
  const _SyncFailedDto({required this.sessionId, required this.reason});
  factory _SyncFailedDto.fromJson(Map<String, dynamic> json) => _$SyncFailedDtoFromJson(json);

@override final  String sessionId;
@override final  String reason;

/// Create a copy of SyncFailedDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncFailedDtoCopyWith<_SyncFailedDto> get copyWith => __$SyncFailedDtoCopyWithImpl<_SyncFailedDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncFailedDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncFailedDto&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.reason, reason) || other.reason == reason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,reason);

@override
String toString() {
  return 'SyncFailedDto(sessionId: $sessionId, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$SyncFailedDtoCopyWith<$Res> implements $SyncFailedDtoCopyWith<$Res> {
  factory _$SyncFailedDtoCopyWith(_SyncFailedDto value, $Res Function(_SyncFailedDto) _then) = __$SyncFailedDtoCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String reason
});




}
/// @nodoc
class __$SyncFailedDtoCopyWithImpl<$Res>
    implements _$SyncFailedDtoCopyWith<$Res> {
  __$SyncFailedDtoCopyWithImpl(this._self, this._then);

  final _SyncFailedDto _self;
  final $Res Function(_SyncFailedDto) _then;

/// Create a copy of SyncFailedDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? reason = null,}) {
  return _then(_SyncFailedDto(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
