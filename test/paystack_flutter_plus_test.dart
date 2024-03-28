import 'package:flutter_test/flutter_test.dart';
import 'package:paystack_flutter_plus/paystack_flutter_plus.dart';
import 'package:paystack_flutter_plus/paystack_flutter_plus_platform_interface.dart';
import 'package:paystack_flutter_plus/paystack_flutter_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPaystackFlutterPlusPlatform
    with MockPlatformInterfaceMixin
    implements PaystackFlutterPlusPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PaystackFlutterPlusPlatform initialPlatform = PaystackFlutterPlusPlatform.instance;

  test('$MethodChannelPaystackFlutterPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPaystackFlutterPlus>());
  });

  test('getPlatformVersion', () async {
    PaystackFlutterPlus paystackFlutterPlusPlugin = PaystackFlutterPlus();
    MockPaystackFlutterPlusPlatform fakePlatform = MockPaystackFlutterPlusPlatform();
    PaystackFlutterPlusPlatform.instance = fakePlatform;

    expect(await paystackFlutterPlusPlugin.getPlatformVersion(), '42');
  });
}
