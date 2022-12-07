import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tuya_iot_plugin/tuya_iot_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('tuya_iot_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await TuyaIotPlugin.platformVersion, '42');
  });
}
