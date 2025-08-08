import 'package:flutter/services.dart';

class NativeTimezone {
  static const MethodChannel _channel = MethodChannel('com.bubble_todo_list.native_timezone');

  static Future<String> getLocalTimezone() async {
    final String timezone = await _channel.invokeMethod('getLocalTimezone');
    return timezone;
  }
}