import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_request.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_resposne.dart';

class TransactionRepository {
  late Dio _dio;

  TransactionRepository([Dio? dio]) {
    _dio = dio ?? Dio();
  }

  Future<Either<String, InitializeTransactionResponse>> initializeTransaction({required InitializeTransactionRequest initializeTransactionRequest}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'https://api.paystack.co/transaction/initialize',
        data: initializeTransactionRequest.toJson(),
      );
      if (response.statusCode == 200 && response.data != null) {
        final initializeTransactionResponse = InitializeTransactionResponse.fromJson(
          response.data!,
        );

        return Right(initializeTransactionResponse);
      } else {
        return Left(response.statusMessage ?? 'Error');
      }
    } on DioError catch (e) {
      return Left(e.toString());
    }
  }
}
