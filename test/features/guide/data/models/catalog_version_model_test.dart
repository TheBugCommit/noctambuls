import 'package:flutter_test/flutter_test.dart';
import 'package:noctambuls/features/guide/data/models/catalog_version_model.dart';

void main() {
  group('CatalogVersionModel.fromJson', () {
    test('version com a String → preserva el valor', () {
      final json = {
        'version': '2024-06-15',
        'lastUpdatedAt': '2024-06-15T20:00:00.000Z',
      };

      final model = CatalogVersionModel.fromJson(json);

      expect(model.version, '2024-06-15');
    });

    test('version com a int → convertit a String via _versionFromJson', () {
      final json = {
        'version': 42,
        'lastUpdatedAt': '2024-06-15T20:00:00.000Z',
      };

      final model = CatalogVersionModel.fromJson(json);

      expect(model.version, '42');
    });

    test('lastUpdatedAt parsejat com a DateTime correctament', () {
      final json = {
        'version': 'v1',
        'lastUpdatedAt': '2024-06-15T20:00:00.000Z',
      };

      final model = CatalogVersionModel.fromJson(json);

      expect(model.lastUpdatedAt, DateTime.utc(2024, 6, 15, 20));
    });
  });
}
