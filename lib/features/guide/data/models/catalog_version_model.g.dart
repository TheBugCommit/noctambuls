// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogVersionModel _$CatalogVersionModelFromJson(Map<String, dynamic> json) =>
    _CatalogVersionModel(
      version: _versionFromJson(json['version']),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
    );

Map<String, dynamic> _$CatalogVersionModelToJson(
  _CatalogVersionModel instance,
) => <String, dynamic>{
  'version': instance.version,
  'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
};
