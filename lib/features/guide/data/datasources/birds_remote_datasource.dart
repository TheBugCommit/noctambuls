import 'package:dio/dio.dart';
import 'package:noctambuls/features/guide/data/models/bird_remote_model.dart';
import 'package:noctambuls/features/guide/data/models/catalog_version_model.dart';

abstract class BirdsRemoteDataSource {
  Future<CatalogVersionModel> getCatalogVersion();

  Future<List<BirdRemoteModel>> getBirdsCatalog();
}

class BirdsRemoteDataSourceImpl implements BirdsRemoteDataSource {
  const BirdsRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<CatalogVersionModel> getCatalogVersion() async {
    final response = await dio.get<dynamic>('/api/catalog/birds/version');

    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Server error response');
    }

    return CatalogVersionModel.fromJson(data);
  }

  @override
  Future<List<BirdRemoteModel>> getBirdsCatalog() async {
    final response = await dio.get<dynamic>('/api/catalog/birds');

    final data = response.data;

    if (data is! Map<String, dynamic> || data['birds'] is! List) {
      throw const FormatException(
        'Invalid response format: expected an object containing a "birds" list',
      );
    }

    final birdsList = data['birds'] as List;

    return birdsList
        .whereType<Map<String, dynamic>>()
        .map(BirdRemoteModel.fromJson)
        .toList();
  }
}
