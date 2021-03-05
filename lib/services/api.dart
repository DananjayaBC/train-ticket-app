import 'package:flutter/foundation.dart';
import 'package:train_ticket_app/services/api_keys.dart';

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ictaSandBoxKey);
  static final int port = 8280;

  Uri tokenUri() => Uri(
        scheme: 'https',
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );
}
