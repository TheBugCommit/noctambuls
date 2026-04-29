class CatalogVersionModel {
  const CatalogVersionModel({
    required this.version,
    required this.lastUpdatedAt,
  });

  factory CatalogVersionModel.fromJson(Map<String, dynamic> json) {
    return CatalogVersionModel(
      version: json['version'].toString(),
      lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
    );
  }

  final String version;
  final DateTime lastUpdatedAt;
}
