import 'package:dio/dio.dart';

extension DioExceptionX on DioException {
  bool get isNetworkError =>
      type == DioExceptionType.connectionTimeout ||
      type == DioExceptionType.sendTimeout ||
      type == DioExceptionType.receiveTimeout ||
      type == DioExceptionType.connectionError ||
      response == null;

  bool get isInfrastructureError {
    final statusCode = response?.statusCode;
    if (statusCode == null) return false;

    if (statusCode >= 500) return true;
    if (statusCode == 404 && !isOurBackendError) return true;

    return false;
  }

  bool get isOurBackendError {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      return data.containsKey('message') &&
          data.containsKey('code') &&
          data.containsKey('details');
    }
    return false;
  }
}
