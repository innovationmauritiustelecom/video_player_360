import 'dart:async';

import 'package:flutter/services.dart';

class VideoPlayer360 {
  static const MethodChannel _channel =
      const MethodChannel('innov.lab/video_player_360');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> playVideoURL(String url) async {
    return _channel.invokeMapMethod("playvideo", <String, dynamic>{
      'video_url': url,
    });
  }
}
