import 'package:dio/dio.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:retrofit/retrofit.dart';
import '../utils/result.dart';

part 'api_client_rm.g.dart';

@RestApi()
abstract class ApiClientRm {
  static Future<Dio> createDioWithAuth() async {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await FirebaseAppCheck.instance.getToken(true);
          if (token != null) {
            options.headers["X-App-Check"] = token;
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  factory ApiClientRm(Dio dio, {String baseUrl}) = _ApiClientRm;

  @GET("/hello")
  Future<Result<String>> getTeste();
}