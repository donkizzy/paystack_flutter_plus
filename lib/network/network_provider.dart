import 'package:dio/dio.dart';
import 'package:paystack_flutter_plus/network/api_error.dart';
import 'package:paystack_flutter_plus/network/app_interceptor.dart';

class NetworkProvider {

  Dio _getDioInstance() {
    var dio = Dio(BaseOptions(
      connectTimeout: const Duration(minutes: 3),
      receiveTimeout: const Duration(minutes: 3),
    ));
    dio.interceptors.add(AppInterceptor());
    dio.interceptors.add(LogInterceptor(
        responseBody: true, error: true, request: true, requestBody: true));

    return dio;
  }

  Future<Response?> call(
      {required String path,
      required RequestMethod method,
      dynamic body = const {},
      Map<String, dynamic> queryParams = const {},
      Map<String, dynamic> headers = const {}
      }) async {
    Response? response;
    try {
      switch (method) {
        case RequestMethod.get:
          response =
              await _getDioInstance().get(path, queryParameters: queryParams,options: Options(headers: headers,));
          break;
        case RequestMethod.post:
          response = await _getDioInstance()
              .post(path, data: body, queryParameters: queryParams,options: Options(headers: headers,));
          break;
        case RequestMethod.patch:
          response = await _getDioInstance()
              .patch(path, data: body, queryParameters: queryParams,options: Options(headers: headers,));
          break;
        case RequestMethod.put:
          response = await _getDioInstance()
              .put(path, data: body, queryParameters: queryParams,options: Options(headers: headers,));
          break;
        case RequestMethod.delete:
          response = await _getDioInstance()
              .delete(path, data: body, queryParameters: queryParams,options: Options(headers: headers,));
          break;
      }

      return response;
    } on DioException catch (e) {
      return await Future.error(ApiError.fromDio(e));
    }
  }


}
enum RequestMethod { get, post, put, patch, delete }
