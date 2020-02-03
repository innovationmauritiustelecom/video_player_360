import 'dart:async';

import 'package:flutter/services.dart';

class VideoPlayer360 {
  static const MethodChannel _channel =
      const MethodChannel('innov.lab/video_player_360');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  ///
  /// Set spherical mesh for the texture. The mesh does not have be closed.
  ///
  /// @param radius Size of the sphere in meters. Must be > 0.
  /// @param verticalFov Total latitudinal degrees that are covered by the sphere. Must be in (0, 180].
  /// @param horizontalFov Total longitudinal degrees that are covered by the sphere.Must be in (0, 360].
  /// @param rows Number of rows that make up the sphere. Must be >= 1.
  /// @param columns Number of columns that make up the sphere. Must be >= 1.
  ///

  static Future<void> playVideoURL(
    String url, {
    int radius = 50,
    int verticalFov = 180,
    int horizontalFov = 360,
    int rows = 50,
    int columns = 50,
    bool showPlaceholder = false,
  }) async {
    return _channel.invokeMapMethod("playvideo", <String, dynamic>{
      'video_url': url,
      'radius': radius,
      'verticalFov': verticalFov,
      'horizontalFov': horizontalFov,
      'rows': rows,
      'columns': columns,
      'showPlaceholder': showPlaceholder,
    });
  }
}
