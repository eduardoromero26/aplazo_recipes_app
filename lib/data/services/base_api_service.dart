import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApiService {
  late final Dio _dio;

  BaseApiService() {
    _dio = Dio();
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ),
    );
  }

  Future<Response> getFromApi(String endpoint) async {
    try {
      final response = await _dio.get('${dotenv.env['API_URL']}$endpoint');
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Future<Response> postToApi(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.post(
        '${dotenv.env['API_URL']}$endpoint',
        data: data,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        return Exception('Bad response: ${e.response?.statusCode}');
      case DioExceptionType.cancel:
        return Exception('Request cancelled');
      case DioExceptionType.unknown:
        return Exception('Network error: ${e.message}');
      default:
        return Exception('Unknown error occurred');
    }
  }
}
