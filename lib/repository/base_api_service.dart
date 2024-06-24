import 'package:dio/dio.dart';
import 'package:fllutter_sitemate_challenge/utils/utils.dart';
import 'api_config.dart';
import 'base_response.dart';

class BaseApiService {
  String tryAgain = 'Please try again.';
  Dio dio = ApiConfig().getServiceInstance();

  ///Get API call for list reponse passing the url and query params
  Future<BaseResponseModel> getArrayResponseWithParams(url, queryParams) async {
    if (await isConnectionAvailable()) {
      try {
        final response = await dio.get(url, queryParameters: queryParams);

        return BaseResponseModel<List<dynamic>>.fromJson(response.data);
      } catch (e) {
        rethrow;
      }
    } else {
      throw Exception('No internet connection');
    }
  }
}
