import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'paystack_flutter_plus_platform_interface.dart';

/// An implementation of [PaystackFlutterPlusPlatform] that uses method channels.
class MethodChannelPaystackFlutterPlus extends PaystackFlutterPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('paystack_flutter_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
