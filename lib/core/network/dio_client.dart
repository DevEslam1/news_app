import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio i;

  DioClient()
      : i = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 15),
            queryParameters: {'apiKey': ApiConstants.apiKey},
          ),
        ) {
    i.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }
}
