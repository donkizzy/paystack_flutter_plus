import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'paystack_flutter_plus_method_channel.dart';

abstract class PaystackFlutterPlusPlatform extends PlatformInterface {
  /// Constructs a PaystackFlutterPlusPlatform.
  PaystackFlutterPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static PaystackFlutterPlusPlatform _instance = MethodChannelPaystackFlutterPlus();

  /// The default instance of [PaystackFlutterPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelPaystackFlutterPlus].
  static PaystackFlutterPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PaystackFlutterPlusPlatform] when
  /// they register themselves.
  static set instance(PaystackFlutterPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
