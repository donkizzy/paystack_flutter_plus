
import 'paystack_flutter_plus_platform_interface.dart';

class PaystackFlutterPlus {
  Future<String?> getPlatformVersion() {
    return PaystackFlutterPlusPlatform.instance.getPlatformVersion();
  }
}
