import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:train_ticket_app/services/http_service.dart';

const BASE_URL = "http://api.lankagate.gov.lk:8280";
const API_KEY = "a9ee0f8c-ab4a-3e22-8b62-5037f5959cb3";

class HttpServiceImpl implements HttpService {
  Dio _dio;

  @override
  Future<Response> getRequest(String url) async {
    Response response;

    try {
      response = await _dio.get(url);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  initializeIntercepters() {
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
      print(error.message);
    }, onRequest: (request) {
      print("${request.method} | ${request.path}");
    }, onResponse: (response) {
      print(
          "${response.statusCode} ${response.statusMessage} ${response.data}");
    }));
  }

  @override
  void init() {
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL, headers: {"Authorization": "Bearer $API_KEY"}));

    initializeIntercepters();
  }
}
