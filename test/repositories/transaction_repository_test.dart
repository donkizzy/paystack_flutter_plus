import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_request.dart';
import 'package:paystack_flutter_plus/network/api_config.dart';
import 'package:paystack_flutter_plus/network/network_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paystack_flutter_plus/repositories/transaction_repository.dart';

import 'transaction_repository_test.mocks.dart';

@GenerateMocks([NetworkProvider])
void main() {
  late TransactionRepository transactionRepository;
  late MockNetworkProvider mockNetworkProvider;

  setUp(() async {
    await dotenv.load(fileName: ".env");
    mockNetworkProvider = MockNetworkProvider();
    transactionRepository = TransactionRepository(mockNetworkProvider);
  });

  group('TransactionRepository', () {
    test('initializeTransaction returns a Right when successful', () async {
      when(mockNetworkProvider.call(
        path: ApiConfig.initializeTransaction,
        method: RequestMethod.post,
        body: {"email": 'john@yopmail.com', "amount": 1000},
        headers: {"Authorization": "Bearer ${dotenv.env['SECRET_KEY']}"},
      )).thenAnswer((_) async => Response(data: {'status': true}, statusCode: 200, requestOptions: RequestOptions()));

      final result = await transactionRepository.initializeTransaction(
          initializeTransactionRequest: InitializeTransactionRequest(
            email: 'john@yopmail.com',
            amount: 1000,
          ),
          secretKey: dotenv.env['SECRET_KEY'] ?? '');
      expect(result, isA<Right>());
    });

    test('initializeTransaction returns a Left when unsuccessful', () async {
      when(mockNetworkProvider.call(
        path: ApiConfig.initializeTransaction,
        method: RequestMethod.post,
        body: {"email": 'john@yopmail.com', "amount": 1000},
        headers: {"Authorization": "Bearer ${dotenv.env['SECRET_KEY']}"},
      )).thenAnswer((_) async => Response(data: {'status': false}, statusCode: 400, requestOptions: RequestOptions()));

      final result = await transactionRepository.initializeTransaction(
          initializeTransactionRequest: InitializeTransactionRequest(
            email: 'john@yopmail.com',
            amount: 1000,
          ),
          secretKey: dotenv.env['SECRET_KEY'] ?? '');
      expect(result, isA<Left>());
    });

    test('verifyPayStackTransaction returns a Right when successful', () async {
      when(mockNetworkProvider.call(
        path: ApiConfig.verifyPayStackTransaction('reference'),
        method: RequestMethod.get,
        headers: {"Authorization": "Bearer ${dotenv.env['SECRET_KEY']}"},
      )).thenAnswer((_) async => Response(data: {
            'data': {
              "status": "success",
              "reference": "rd0bz6z2wu",
              "amount": 20000,
            }
          }, statusCode: 200, requestOptions: RequestOptions()));

      final result = await transactionRepository.verifyPayStackTransaction(
        reference: 'reference',
        secretKey: dotenv.env['SECRET_KEY'] ?? '',
      );

      expect(result, isA<Right>());
    });

    test('verifyPayStackTransaction returns a Left when unsuccessful', () async {
      when(mockNetworkProvider.call(
        path: anyNamed('path'),
        method: anyNamed('method'),
        headers: anyNamed('headers'),
      )).thenAnswer(
          (_) async => Response(data: {'message': 'error'}, statusCode: 400, requestOptions: RequestOptions()));

      final result = await transactionRepository.verifyPayStackTransaction(
        reference: 'reference',
        secretKey: 'secretKey',
      );

      expect(result, isA<Left>());
    });
  });
}
