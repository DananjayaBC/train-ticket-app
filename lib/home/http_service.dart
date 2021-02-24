import 'package:dio/dio.dart';

class HttpService {
  Dio _dio;

  final baseUrl = "http://api.lankagate.gov.lk:8280";

  HttpService() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer 916f2a74-fc1b-3052-82d6-78d1a3ec7547',
      "content-type": "application/json;charset=UTF-8"
    }));

    intializeInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  intializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
      print(error.message);
    }, onRequest: (request) {
      print("${request.method} ${request.path}");
    }, onResponse: (response) {
      print(response.data);
    }));
  }
}
