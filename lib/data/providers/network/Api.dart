import 'package:dio/dio.dart';
import 'package:doctorcare/data/providers/network/AppInterceptor.dart';

class Api {
  final dio = createDio();
  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: 'http://doctorcare.site/api',
      receiveTimeout: 15000, // 15 seconds
      connectTimeout: 15000,
      sendTimeout: 15000,
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });

    return dio;
  }
}