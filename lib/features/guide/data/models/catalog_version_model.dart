import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_version_model.freezed.dart';
part 'catalog_version_model.g.dart';

@freezed
abstract class CatalogVersionModel with _$CatalogVersionModel {
  const factory CatalogVersionModel({
    @JsonKey(fromJson: _versionFromJson) required String version,
    required DateTime lastUpdatedAt,
  }) = _CatalogVersionModel;

  factory CatalogVersionModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogVersionModelFromJson(json);
}

String _versionFromJson(dynamic value) => value.toString();
