import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<void> get showToast async {
     _channel.invokeMethod('toast');

  }

  static Future<void>  enableBluetooth() async {
     _channel.invokeMethod('bluetooth');
  }
}
