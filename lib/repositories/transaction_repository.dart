import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_request.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_resposne.dart';
import 'package:paystack_flutter_plus/models/transaction_response.dart';
import 'package:paystack_flutter_plus/network/api_config.dart';
import 'package:paystack_flutter_plus/network/network_provider.dart';

class TransactionRepository {
  late NetworkProvider _networkProvider;

  TransactionRepository([NetworkProvider? networkProvider]) {
    _networkProvider = networkProvider ?? NetworkProvider();
  }

  Future<Either<String, InitializeTransactionResponse>> initializeTransaction(
      {required InitializeTransactionRequest initializeTransactionRequest, required String secretKey}) async {
    try {
      final response = await _networkProvider.call(
          path: ApiConfig.initializeTransaction,
          method: RequestMethod.post,
          headers: {"Authorization": "Bearer $secretKey"},
          body: initializeTransactionRequest.toJson());

      if (response?.statusCode == 200 && response?.data != null && response?.data['status']) {
        final initializeTransactionResponse = InitializeTransactionResponse.fromJson(
          response!.data,
        );
        return Right(initializeTransactionResponse);
      } else {
        return Left(response?.data['message'] ?? 'Failed to initialize transaction');
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, TransactionResponse>> verifyPayStackTransaction(
      {required String reference, required String secretKey}) async {
    try {
      var response = await _networkProvider.call(
          path: ApiConfig.verifyPayStackTransaction(reference),
          method: RequestMethod.get,
          headers: {"Authorization": "Bearer $secretKey"});
      if (response!.statusCode == 200) {
        TransactionResponse cardResponse = TransactionResponse.fromJson(response.data['data']);
        return Right(cardResponse);
      } else {
        return Left(response.data['message']);
      }
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
