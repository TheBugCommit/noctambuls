import 'package:dio/dio.dart';
import 'package:noctambuls/features/explore/data/models/api/map_bubbles_response_model.dart';

abstract class ExploreRemoteDataSource {
  Future<MapBubblesResponseModel> fetch({String? since});
}

class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSource {
  const ExploreRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<MapBubblesResponseModel> fetch({String? since}) async {
    final response = await dio.get<dynamic>(
      '/api/analytics/map-bubbles',
      queryParameters: {
        'since': ?since,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON object");
    }
    return MapBubblesResponseModel.fromJson(data);
  }
}
