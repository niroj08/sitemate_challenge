import 'package:dio/dio.dart';
import 'end_points.dart';

class ApiConfig {
  Dio dio = Dio();

  Dio getServiceInstance() {
    dio.options.baseUrl = EndPoints.baseUrl;

    dio.options.contentType = "application/json";
    dio.options.headers["Accept"] = "application/json";
    dio.options.connectTimeout = const Duration(minutes: 1); //1min
    dio.options.receiveTimeout = const Duration(minutes: 2); // 1min
    dio.options.sendTimeout = const Duration(minutes: 2);
    return dio;
  }
}
