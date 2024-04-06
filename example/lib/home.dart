import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paystack_flutter_plus/paystack_flutter_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _paystackFlutterPlusPlugin = PaystackFlutterPlus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: MaterialButton(
              elevation: 0.0,
              color: Colors.lightBlue,
              textColor: Colors.white,
              child: const Text('Pay'),
              onPressed: () {
                _paystackFlutterPlusPlugin.pay(
                  secretKey: dotenv.env['SECRET_KEY'] ?? '', //replace with your own secret key
                  amount: 10000, //replace with your own amount
                  // currency: Currency.NGN,
                  // bearer: FeeBearer.ACCOUNT,
                  email: "amosgodwin500@gmail.com",
                  context: context,
                  onTransactionCompleted: () {},
                  onTransactionCancelled: () {},
                );
              }),
        ));
  }
}
