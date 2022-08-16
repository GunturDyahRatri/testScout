import 'package:dio/dio.dart';
import 'package:testscout/constant/constant.dart';
import 'package:testscout/utils/base_interceptor.dart';

class ApiService {
  final dio = createDio();
  // final tokenDio = Dio(BaseOptions(baseUrl: Globals().Url));

  ApiService._internal();

  static final _singleton = ApiService._internal();

  factory ApiService() => _singleton;

  static Dio createDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveTimeout: 15000, // 15 seconds
        connectTimeout: 15000,
        sendTimeout: 15000,
      ),
    );

    dio.interceptors.addAll({
      BaseInterceptor(),
    });
    return dio;
  }
}
