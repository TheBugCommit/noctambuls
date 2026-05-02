// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bird_remote_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BirdRemoteModel {

 String get id; String get scientificName; String get imagePath; String get audioPath;@JsonKey(readValue: _injectBirdIdInTranslations) List<BirdNameRemoteModel> get translations;@JsonKey(name: 'informationUrl') String? get infoUrl;
/// Create a copy of BirdRemoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirdRemoteModelCopyWith<BirdRemoteModel> get copyWith => _$BirdRemoteModelCopyWithImpl<BirdRemoteModel>(this as BirdRemoteModel, _$identity);

  /// Serializes this BirdRemoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirdRemoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.scientificName, scientificName) || other.scientificName == scientificName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&const DeepCollectionEquality().equals(other.translations, translations)&&(identical(other.infoUrl, infoUrl) || other.infoUrl == infoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scientificName,imagePath,audioPath,const DeepCollectionEquality().hash(translations),infoUrl);

@override
String toString() {
  return 'BirdRemoteModel(id: $id, scientificName: $scientificName, imagePath: $imagePath, audioPath: $audioPath, translations: $translations, infoUrl: $infoUrl)';
}


}

/// @nodoc
abstract mixin class $BirdRemoteModelCopyWith<$Res>  {
  factory $BirdRemoteModelCopyWith(BirdRemoteModel value, $Res Function(BirdRemoteModel) _then) = _$BirdRemoteModelCopyWithImpl;
@useResult
$Res call({
 String id, String scientificName, String imagePath, String audioPath,@JsonKey(readValue: _injectBirdIdInTranslations) List<BirdNameRemoteModel> translations,@JsonKey(name: 'informationUrl') String? infoUrl
});




}
/// @nodoc
class _$BirdRemoteModelCopyWithImpl<$Res>
    implements $BirdRemoteModelCopyWith<$Res> {
  _$BirdRemoteModelCopyWithImpl(this._self, this._then);

  final BirdRemoteModel _self;
  final $Res Function(BirdRemoteModel) _then;

/// Create a copy of BirdRemoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scientificName = null,Object? imagePath = null,Object? audioPath = null,Object? translations = null,Object? infoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scientificName: null == scientificName ? _self.scientificName : scientificName // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,audioPath: null == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self.translations : translations // ignore: cast_nullable_to_non_nullable
as List<BirdNameRemoteModel>,infoUrl: freezed == infoUrl ? _self.infoUrl : infoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BirdRemoteModel].
extension BirdRemoteModelPatterns on BirdRemoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirdRemoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirdRemoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirdRemoteModel value)  $default,){
final _that = this;
switch (_that) {
case _BirdRemoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirdRemoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _BirdRemoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String scientificName,  String imagePath,  String audioPath, @JsonKey(readValue: _injectBirdIdInTranslations)  List<BirdNameRemoteModel> translations, @JsonKey(name: 'informationUrl')  String? infoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BirdRemoteModel() when $default != null:
return $default(_that.id,_that.scientificName,_that.imagePath,_that.audioPath,_that.translations,_that.infoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String scientificName,  String imagePath,  String audioPath, @JsonKey(readValue: _injectBirdIdInTranslations)  List<BirdNameRemoteModel> translations, @JsonKey(name: 'informationUrl')  String? infoUrl)  $default,) {final _that = this;
switch (_that) {
case _BirdRemoteModel():
return $default(_that.id,_that.scientificName,_that.imagePath,_that.audioPath,_that.translations,_that.infoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String scientificName,  String imagePath,  String audioPath, @JsonKey(readValue: _injectBirdIdInTranslations)  List<BirdNameRemoteModel> translations, @JsonKey(name: 'informationUrl')  String? infoUrl)?  $default,) {final _that = this;
switch (_that) {
case _BirdRemoteModel() when $default != null:
return $default(_that.id,_that.scientificName,_that.imagePath,_that.audioPath,_that.translations,_that.infoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BirdRemoteModel extends BirdRemoteModel {
  const _BirdRemoteModel({required this.id, required this.scientificName, required this.imagePath, required this.audioPath, @JsonKey(readValue: _injectBirdIdInTranslations) required final  List<BirdNameRemoteModel> translations, @JsonKey(name: 'informationUrl') this.infoUrl}): _translations = translations,super._();
  factory _BirdRemoteModel.fromJson(Map<String, dynamic> json) => _$BirdRemoteModelFromJson(json);

@override final  String id;
@override final  String scientificName;
@override final  String imagePath;
@override final  String audioPath;
 final  List<BirdNameRemoteModel> _translations;
@override@JsonKey(readValue: _injectBirdIdInTranslations) List<BirdNameRemoteModel> get translations {
  if (_translations is EqualUnmodifiableListView) return _translations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_translations);
}

@override@JsonKey(name: 'informationUrl') final  String? infoUrl;

/// Create a copy of BirdRemoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirdRemoteModelCopyWith<_BirdRemoteModel> get copyWith => __$BirdRemoteModelCopyWithImpl<_BirdRemoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BirdRemoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirdRemoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.scientificName, scientificName) || other.scientificName == scientificName)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&const DeepCollectionEquality().equals(other._translations, _translations)&&(identical(other.infoUrl, infoUrl) || other.infoUrl == infoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scientificName,imagePath,audioPath,const DeepCollectionEquality().hash(_translations),infoUrl);

@override
String toString() {
  return 'BirdRemoteModel(id: $id, scientificName: $scientificName, imagePath: $imagePath, audioPath: $audioPath, translations: $translations, infoUrl: $infoUrl)';
}


}

/// @nodoc
abstract mixin class _$BirdRemoteModelCopyWith<$Res> implements $BirdRemoteModelCopyWith<$Res> {
  factory _$BirdRemoteModelCopyWith(_BirdRemoteModel value, $Res Function(_BirdRemoteModel) _then) = __$BirdRemoteModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String scientificName, String imagePath, String audioPath,@JsonKey(readValue: _injectBirdIdInTranslations) List<BirdNameRemoteModel> translations,@JsonKey(name: 'informationUrl') String? infoUrl
});




}
/// @nodoc
class __$BirdRemoteModelCopyWithImpl<$Res>
    implements _$BirdRemoteModelCopyWith<$Res> {
  __$BirdRemoteModelCopyWithImpl(this._self, this._then);

  final _BirdRemoteModel _self;
  final $Res Function(_BirdRemoteModel) _then;

/// Create a copy of BirdRemoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scientificName = null,Object? imagePath = null,Object? audioPath = null,Object? translations = null,Object? infoUrl = freezed,}) {
  return _then(_BirdRemoteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,scientificName: null == scientificName ? _self.scientificName : scientificName // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,audioPath: null == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String,translations: null == translations ? _self._translations : translations // ignore: cast_nullable_to_non_nullable
as List<BirdNameRemoteModel>,infoUrl: freezed == infoUrl ? _self.infoUrl : infoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BirdNameRemoteModel {

 String get id; String get birdId; String get languageCode; String get commonName; String get description;
/// Create a copy of BirdNameRemoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BirdNameRemoteModelCopyWith<BirdNameRemoteModel> get copyWith => _$BirdNameRemoteModelCopyWithImpl<BirdNameRemoteModel>(this as BirdNameRemoteModel, _$identity);

  /// Serializes this BirdNameRemoteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BirdNameRemoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.birdId, birdId) || other.birdId == birdId)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birdId,languageCode,commonName,description);

@override
String toString() {
  return 'BirdNameRemoteModel(id: $id, birdId: $birdId, languageCode: $languageCode, commonName: $commonName, description: $description)';
}


}

/// @nodoc
abstract mixin class $BirdNameRemoteModelCopyWith<$Res>  {
  factory $BirdNameRemoteModelCopyWith(BirdNameRemoteModel value, $Res Function(BirdNameRemoteModel) _then) = _$BirdNameRemoteModelCopyWithImpl;
@useResult
$Res call({
 String id, String birdId, String languageCode, String commonName, String description
});




}
/// @nodoc
class _$BirdNameRemoteModelCopyWithImpl<$Res>
    implements $BirdNameRemoteModelCopyWith<$Res> {
  _$BirdNameRemoteModelCopyWithImpl(this._self, this._then);

  final BirdNameRemoteModel _self;
  final $Res Function(BirdNameRemoteModel) _then;

/// Create a copy of BirdNameRemoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? birdId = null,Object? languageCode = null,Object? commonName = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,birdId: null == birdId ? _self.birdId : birdId // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,commonName: null == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BirdNameRemoteModel].
extension BirdNameRemoteModelPatterns on BirdNameRemoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BirdNameRemoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BirdNameRemoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BirdNameRemoteModel value)  $default,){
final _that = this;
switch (_that) {
case _BirdNameRemoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BirdNameRemoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _BirdNameRemoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String birdId,  String languageCode,  String commonName,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BirdNameRemoteModel() when $default != null:
return $default(_that.id,_that.birdId,_that.languageCode,_that.commonName,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String birdId,  String languageCode,  String commonName,  String description)  $default,) {final _that = this;
switch (_that) {
case _BirdNameRemoteModel():
return $default(_that.id,_that.birdId,_that.languageCode,_that.commonName,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String birdId,  String languageCode,  String commonName,  String description)?  $default,) {final _that = this;
switch (_that) {
case _BirdNameRemoteModel() when $default != null:
return $default(_that.id,_that.birdId,_that.languageCode,_that.commonName,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BirdNameRemoteModel extends BirdNameRemoteModel {
  const _BirdNameRemoteModel({required this.id, required this.birdId, required this.languageCode, required this.commonName, required this.description}): super._();
  factory _BirdNameRemoteModel.fromJson(Map<String, dynamic> json) => _$BirdNameRemoteModelFromJson(json);

@override final  String id;
@override final  String birdId;
@override final  String languageCode;
@override final  String commonName;
@override final  String description;

/// Create a copy of BirdNameRemoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BirdNameRemoteModelCopyWith<_BirdNameRemoteModel> get copyWith => __$BirdNameRemoteModelCopyWithImpl<_BirdNameRemoteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BirdNameRemoteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BirdNameRemoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.birdId, birdId) || other.birdId == birdId)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.commonName, commonName) || other.commonName == commonName)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,birdId,languageCode,commonName,description);

@override
String toString() {
  return 'BirdNameRemoteModel(id: $id, birdId: $birdId, languageCode: $languageCode, commonName: $commonName, description: $description)';
}


}

/// @nodoc
abstract mixin class _$BirdNameRemoteModelCopyWith<$Res> implements $BirdNameRemoteModelCopyWith<$Res> {
  factory _$BirdNameRemoteModelCopyWith(_BirdNameRemoteModel value, $Res Function(_BirdNameRemoteModel) _then) = __$BirdNameRemoteModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String birdId, String languageCode, String commonName, String description
});




}
/// @nodoc
class __$BirdNameRemoteModelCopyWithImpl<$Res>
    implements _$BirdNameRemoteModelCopyWith<$Res> {
  __$BirdNameRemoteModelCopyWithImpl(this._self, this._then);

  final _BirdNameRemoteModel _self;
  final $Res Function(_BirdNameRemoteModel) _then;

/// Create a copy of BirdNameRemoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? birdId = null,Object? languageCode = null,Object? commonName = null,Object? description = null,}) {
  return _then(_BirdNameRemoteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,birdId: null == birdId ? _self.birdId : birdId // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,commonName: null == commonName ? _self.commonName : commonName // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
