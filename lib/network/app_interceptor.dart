import 'package:dio/dio.dart';


class AppInterceptor extends Interceptor {


  @override
  void onResponse(Response response, ResponseInterceptorHandler handler)  {
    if (response.statusCode! >= 200 && response.statusCode! < 400) {
      response.statusCode = 200;
    }
    return super.onResponse(response, handler);
  }
}
