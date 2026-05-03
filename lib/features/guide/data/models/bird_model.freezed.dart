// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bird_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BirdModel {

 String get id; String get commonName; String get scientificName; String get description; String get imageUrl; String get audioUrl; String get infoUrl; String? get localAudioPath; String? get localImagePath;
/// Create a copy of BirdModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirdModelCopyWith<BirdModel> get copyWith => _$BirdModelCopyWithImpl<BirdModel>(this as BirdModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.scientificName, scientificName) || other.scientificName == scientificName)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.infoUrl, infoUrl) || other.infoUrl == infoUrl)&&(identical(other.localAudioPath, localAudioPath) || other.localAudioPath == localAudioPath)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}


@override
int get hashCode => Object.hash(runtimeType,id,commonName,scientificName,description,imageUrl,audioUrl,infoUrl,localAudioPath,localImagePath);

@override
String toString() {
  return 'BirdModel(id: $id, commonName: $commonName, scientificName: $scientificName, description: $description, imageUrl: $imageUrl, audioUrl: $audioUrl, infoUrl: $infoUrl, localAudioPath: $localAudioPath, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class $BirdModelCopyWith<$Res>  {
  factory $BirdModelCopyWith(BirdModel value, $Res Function(BirdModel) _then) = _$BirdModelCopyWithImpl;
@useResult
$Res call({
 String id, String commonName, String scientificName, String description, String imageUrl, String audioUrl, String infoUrl, String? localAudioPath, String? localImagePath
});




}
/// @nodoc
class _$BirdModelCopyWithImpl<$Res>
    implements $BirdModelCopyWith<$Res> {
  _$BirdModelCopyWithImpl(this._self, this._then);

  final BirdModel _self;
  final $Res Function(BirdModel) _then;

/// Create a copy of BirdModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? commonName = null,Object? scientificName = null,Object? description = null,Object? imageUrl = null,Object? audioUrl = null,Object? infoUrl = null,Object? localAudioPath = freezed,Object? localImagePath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commonName: null == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String,scientificName: null == scientificName ? _self.scientificName : scientificName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,infoUrl: null == infoUrl ? _self.infoUrl : infoUrl // ignore: cast_nullable_to_non_nullable
as String,localAudioPath: freezed == localAudioPath ? _self.localAudioPath : localAudioPath // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BirdModel].
extension BirdModelPatterns on BirdModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirdModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirdModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirdModel value)  $default,){
final _that = this;
switch (_that) {
case _BirdModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirdModel value)?  $default,){
final _that = this;
switch (_that) {
case _BirdModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String commonName,  String scientificName,  String description,  String imageUrl,  String audioUrl,  String infoUrl,  String? localAudioPath,  String? localImagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BirdModel() when $default != null:
return $default(_that.id,_that.commonName,_that.scientificName,_that.description,_that.imageUrl,_that.audioUrl,_that.infoUrl,_that.localAudioPath,_that.localImagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String commonName,  String scientificName,  String description,  String imageUrl,  String audioUrl,  String infoUrl,  String? localAudioPath,  String? localImagePath)  $default,) {final _that = this;
switch (_that) {
case _BirdModel():
return $default(_that.id,_that.commonName,_that.scientificName,_that.description,_that.imageUrl,_that.audioUrl,_that.infoUrl,_that.localAudioPath,_that.localImagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String commonName,  String scientificName,  String description,  String imageUrl,  String audioUrl,  String infoUrl,  String? localAudioPath,  String? localImagePath)?  $default,) {final _that = this;
switch (_that) {
case _BirdModel() when $default != null:
return $default(_that.id,_that.commonName,_that.scientificName,_that.description,_that.imageUrl,_that.audioUrl,_that.infoUrl,_that.localAudioPath,_that.localImagePath);case _:
  return null;

}
}

}

/// @nodoc


class _BirdModel implements BirdModel {
  const _BirdModel({required this.id, required this.commonName, required this.scientificName, required this.description, required this.imageUrl, required this.audioUrl, required this.infoUrl, this.localAudioPath, this.localImagePath});
  

@override final  String id;
@override final  String commonName;
@override final  String scientificName;
@override final  String description;
@override final  String imageUrl;
@override final  String audioUrl;
@override final  String infoUrl;
@override final  String? localAudioPath;
@override final  String? localImagePath;

/// Create a copy of BirdModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirdModelCopyWith<_BirdModel> get copyWith => __$BirdModelCopyWithImpl<_BirdModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirdModel&&(identical(other.id, id) || other.id == id)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.scientificName, scientificName) || other.scientificName == scientificName)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.infoUrl, infoUrl) || other.infoUrl == infoUrl)&&(identical(other.localAudioPath, localAudioPath) || other.localAudioPath == localAudioPath)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}


@override
int get hashCode => Object.hash(runtimeType,id,commonName,scientificName,description,imageUrl,audioUrl,infoUrl,localAudioPath,localImagePath);

@override
String toString() {
  return 'BirdModel(id: $id, commonName: $commonName, scientificName: $scientificName, description: $description, imageUrl: $imageUrl, audioUrl: $audioUrl, infoUrl: $infoUrl, localAudioPath: $localAudioPath, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class _$BirdModelCopyWith<$Res> implements $BirdModelCopyWith<$Res> {
  factory _$BirdModelCopyWith(_BirdModel value, $Res Function(_BirdModel) _then) = __$BirdModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String commonName, String scientificName, String description, String imageUrl, String audioUrl, String infoUrl, String? localAudioPath, String? localImagePath
});




}
/// @nodoc
class __$BirdModelCopyWithImpl<$Res>
    implements _$BirdModelCopyWith<$Res> {
  __$BirdModelCopyWithImpl(this._self, this._then);

  final _BirdModel _self;
  final $Res Function(_BirdModel) _then;

/// Create a copy of BirdModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? commonName = null,Object? scientificName = null,Object? description = null,Object? imageUrl = null,Object? audioUrl = null,Object? infoUrl = null,Object? localAudioPath = freezed,Object? localImagePath = freezed,}) {
  return _then(_BirdModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,commonName: null == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String,scientificName: null == scientificName ? _self.scientificName : scientificName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,infoUrl: null == infoUrl ? _self.infoUrl : infoUrl // ignore: cast_nullable_to_non_nullable
as String,localAudioPath: freezed == localAudioPath ? _self.localAudioPath : localAudioPath // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
