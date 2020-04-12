//const String server = "127.0.0.1:8001";
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/utils/constants.dart';




class RemoteApiManager {
  static final RemoteApiManager _instance = RemoteApiManager._internal();

  factory RemoteApiManager() {
    return _instance;
  }

  RemoteApiManager._internal();

  Dio _dio;
  Dio getDio() {
    BaseOptions options = new BaseOptions(
        connectTimeout: 5000,
        receiveTimeout: 8000,
        baseUrl: BASE_API_URL,
        headers: {"Authorization": "Bearer ${DotEnv().env['UID']}"});
    Dio dio = new Dio(options);
    _dio = dio;
    return _dio;
  }
}
