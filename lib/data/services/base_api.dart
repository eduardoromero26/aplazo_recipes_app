import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApi {
  final Dio dio = Dio();
  Future getFromApi(String endpoint) async {
    try {
      final response = await dio.get('${dotenv.env['API_URL']}$endpoint');
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}
