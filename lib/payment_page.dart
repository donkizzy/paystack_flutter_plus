import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:paystack_flutter_plus/enums.dart';
import 'package:paystack_flutter_plus/repositories/transaction_repository.dart';
import 'package:paystack_flutter_plus/models/initialize_transaction_request.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'models/initialize_transaction_resposne.dart';

class PaymentPage extends StatefulWidget {


  ///YOUR_SECRET_KEY
  final String secretKey;

  ///Amount should be in the subunit of the supported currency
  final num amount;

  ///The transaction currency. Defaults to your integration currency.
  final Currency? currency;

  ///Customer's email address
  final String email;

  ///Unique transaction reference. Only -, ., = and alphanumeric characters allowed.
  final String? reference;

  /// An array of payment channels to control what channels you want to make available to the user to make a payment with.
  /// see [PaymentChannels] { CARD, BANK , USSD , QR, MOBILE_MONEY, BANK_TRANSFER, EFT }
  final List<PaymentChannels>? paymentChannels;

  ///Fully qualified url, e.g. https://example.com/ . Use this to override the callback url provided on the dashboard for this transaction
  final String? callbackUrl;

  ///If transaction is to create a subscription to a predefined plan, provide plan code here. This would invalidate the value provided in amount
  final String? plan;

  ///Who bears Paystack charges? [FeeBearer.ACCOUNT] or [FeeBearer.SUB_ACCOUNT] (defaults to account).
  final FeeBearer? bearer;

  ///An amount used to override the split configuration for a single split payment. If set, the amount specified goes to the main account regardless of the split configuration.
  final num? transactionCharge;

  ///The split code of the transaction split. e.g. SPL_98WF13Eb3w
  final String? splitCode;

  ///The code for the subaccount that owns the payment. e.g. ACCT_8f4s1eq7ml6rlzj
  final String? subAccount;

  ///Number of times to charge customer during subscription to plan
  final int? invoiceLimit;

  /// callback for when a transaction is completed
  final Function? onTransactionCompleted;

  /// callback for when a transaction is cancelled
  final Function? onTransactionCancelled;

  /// BuildContext context for navigation
  final BuildContext context ;

  const PaymentPage({
    super.key,
    required this.secretKey,
    required this.amount,
    this.currency,
    required this.email,
    this.reference,
    this.paymentChannels,
    this.callbackUrl,
    this.plan,
    this.bearer,
    this.transactionCharge,
    this.splitCode,
    this.subAccount,
    this.invoiceLimit,
    this.onTransactionCompleted,
    this.onTransactionCancelled,
    required this.context
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TransactionRepository _transactionRepository;
  late Future<dartz.Either<String, InitializeTransactionResponse>> _initializeTransactionFuture;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _transactionRepository = TransactionRepository();
    initializeWebView();
    _initializeTransactionFuture = _initializeTransaction();
  }

  Future<dartz.Either<String, InitializeTransactionResponse>> _initializeTransaction() async {
    InitializeTransactionRequest request = InitializeTransactionRequest(
      email: widget.email,
      amount: widget.amount.toInt(),
      reference: widget.reference,
      currency: widget.currency.toString(),
      channels: widget.paymentChannels?.map((e) => e.toString().toLowerCase()).toList(),
      bearer: widget.bearer.toString().toLowerCase(),
      callbackUrl: widget.callbackUrl,
      invoiceLimit: widget.invoiceLimit,
      plan: widget.plan,
      splitCode: widget.splitCode,
      subAccount: widget.subAccount,
      transactionCharge: widget.transactionCharge,
    );
    return await _transactionRepository.initializeTransaction(initializeTransactionRequest: request);
  }

  initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent("Flutter;Webview")
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          await handleCallbackUrl(request.url);
          return NavigationDecision.navigate;
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dartz.Either<String, InitializeTransactionResponse>>(
        future: _initializeTransactionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error initializing transaction: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              var result = snapshot.data;
              result?.fold((l) {
                return Center(child: Text('Error initializing transaction: ${snapshot.error}'));
              }, (r) {
                _controller.loadRequest(Uri.parse(r.data?.authorizationUrl ?? ''));
                return WebViewWidget(
                  controller: _controller,
                );
              });

              return WebViewWidget(
                controller: _controller,
              );
            }
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Future<bool> _checkTransactionStatusSuccessful(String reference) async {
    try {
      final result = await _transactionRepository.verifyPayStackTransaction(
        reference: reference,
        secretKey: widget.secretKey,
      );

      return result.fold(
        (error) {
          return false;
        },
        (transactionResponse) {
          if (transactionResponse.gatewayResponse == 'Approved') {
            return true;
          } else {
            return false;
          }
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> handleCallbackUrl(String url) async {
    if (url.contains('cancelurl.com') ||
        url.contains('paystack.co/close') ||
        url.contains(widget.callbackUrl ?? '') ||
        url == "https://hello.pstk.xyz/callback") {
      bool transactionSuccessful = await _checkTransactionStatusSuccessful(widget.reference ?? '');
      if (widget.context.mounted) {
        if (transactionSuccessful) {
          widget.onTransactionCompleted?.call();
          Navigator.of(widget.context).pop();
        } else {
          widget.onTransactionCancelled?.call();
          Navigator.of(widget.context).pop();
        }
      }
    }
  }
}
