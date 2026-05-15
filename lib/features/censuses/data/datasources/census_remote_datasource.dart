import 'package:dio/dio.dart';
import 'package:noctambuls/features/censuses/data/models/api/censuses_response_model.dart';

abstract class CensusRemoteDataSource {
  Future<CensusesResponseModel> fetchCensuses({String? since});
}

class CensusRemoteDataSourceImpl implements CensusRemoteDataSource {
  const CensusRemoteDataSourceImpl({required this.dio});

  final Dio dio;

  @override
  Future<CensusesResponseModel> fetchCensuses({String? since}) async {
    final response = await dio.get<dynamic>(
      '/api/censuses',
      queryParameters: {
        if (since != null) 'since': since,
      },
    );
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw const FormatException("Server response isn't a valid JSON object");
    }
    return CensusesResponseModel.fromJson(data);
  }
}
