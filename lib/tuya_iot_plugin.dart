
import 'dart:async';

import 'package:flutter/services.dart';

class TuyaIotPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tuya_iot_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> startConfig(String ssid,String password,String authToken,String pairType) async {
    final bool res = await _channel.invokeMethod('startConfig',{"ssid":ssid,"password":password,"authToken":authToken,"pairType":pairType});
    return res;
  }

  static Future<bool> stopConfig(String pairType) async {
    final bool res = await _channel.invokeMethod('stopConfig',{"pairType":pairType});
    return res;
  }

  // EZ/wired
}
