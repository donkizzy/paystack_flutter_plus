import 'package:dio/dio.dart';

class ApiError {
  String? errorDescription;
  ApiError();


  ApiError.fromDio(Object dioError,  ) {
    handleError(dioError);
  }

  String handleError(Object dioError)  {
    String? error;
    if (dioError is DioException) {
      switch (dioError.type) {
        case DioExceptionType.cancel:
          error = "Request was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          error = "Connection timeout";
          break;
        case DioExceptionType.badResponse:
          error = dioError.response?.statusMessage ??  "An error occurred";
          break;
        case DioExceptionType.unknown:
          error = "An unknown error occurred";
          break;
        case DioExceptionType.badCertificate:
          error = "Bad Certificate";
          break;
        case DioExceptionType.connectionError:
          error = "Unable to connect";
          break;
      }
    } else {
      error = "An unexpected error occurred";
    }
    errorDescription = error ;
    return error ;
  }



  @override
  String toString() => errorDescription ?? '';
}
