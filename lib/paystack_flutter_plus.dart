import 'package:flutter/material.dart';
import 'package:paystack_flutter_plus/enums.dart';
import 'package:paystack_flutter_plus/payment_page.dart';

class PaystackFlutterPlus {
  /// [secretKey] YOUR_SECRET_KEY
  ///
  /// [amount] Amount should be in the subunit of the supported currency
  ///
  /// [currency]The transaction currency. Defaults to your integration currency.
  ///
  /// [email] Customer's email address
  ///
  /// [reference] Unique transaction reference. Only -, ., = and alphanumeric characters allowed.
  ///
  /// [paymentChannels] An array of payment channels to control what channels you want to make available to the user to make a payment with.
  /// see [PaymentChannels] { CARD, BANK , USSD , QR, MOBILE_MONEY, BANK_TRANSFER, EFT }
  ///
  ///String? [callbackUrl] Fully qualified url, e.g. https://example.com/ . Use this to override the callback url provided on the dashboard for this transaction
  ///
  /// String? [plan] If transaction is to create a subscription to a predefined plan, provide plan code here. This would invalidate the value provided in amount
  ///
  /// [FeeBearer]? [bearer], Who bears Paystack charges? [FeeBearer.ACCOUNT] or [FeeBearer.SUB_ACCOUNT] (defaults to account).
  ///
  /// [transactionCharge] An amount used to override the split configuration for a single split payment. If set, the amount specified goes to the main account regardless of the split configuration.
  ///
  /// [splitCode] The split code of the transaction split. e.g. SPL_98WF13Eb3w
  ///
  /// [subAccount] The code for the subaccount that owns the payment. e.g. ACCT_8f4s1eq7ml6rlzj
  ///
  /// [invoiceLimit] Number of times to charge customer during subscription to plan
  ///
  ///  [onTransactionCompleted] callback for when a transaction is completed   ,
  ///
  /// [onTransactionCancelled] callback for when a transaction is cancelledFunction? onTransactionCancelled;
  ///
  /// [context] BuildContext context for navigation

  void pay(
      {required String secretKey,
      required num amount,
      final Currency? currency,
      required String email,
      String? reference,
      List<PaymentChannels>? paymentChannels,
      String? callbackUrl,
      String? plan,
      FeeBearer? bearer,
      num? transactionCharge,
      String? splitCode,
      String? subAccount,
      int? invoiceLimit,
      Function? onTransactionCompleted,
      final Function? onTransactionCancelled,
      required final BuildContext context}) {
    showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        child: PaymentPage(
          context: context,
          secretKey: secretKey,
          amount: amount,
          email: email,
          bearer: bearer,
          callbackUrl: callbackUrl,
          currency: currency,
          invoiceLimit: invoiceLimit,
          onTransactionCancelled: onTransactionCancelled,
          onTransactionCompleted: onTransactionCompleted,
          paymentChannels: paymentChannels,
          plan: plan,
          reference: reference,
          splitCode: splitCode,
          subAccount: subAccount,
          transactionCharge: transactionCharge,
        ),
      );
    },);

  }
}
