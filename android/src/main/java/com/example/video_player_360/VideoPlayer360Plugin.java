package com.example.video_player_360;

import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.video_player_360.videoplayer.VideoActivity;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** VideoPlayer360Plugin */
public class VideoPlayer360Plugin implements FlutterPlugin, MethodCallHandler {
  private Context context;
  public static String VIDEO_URL = "";

/** A spherical mesh for video should be large enough that there are no stereo artifacts. */
  public static int SPHERE_RADIUS_METERS = 50;

/** These should be configured based on the video type. But this sample assumes 360 video. */
  public static int DEFAULT_SPHERE_VERTICAL_DEGREES = 180;
  public static int DEFAULT_SPHERE_HORIZONTAL_DEGREES = 360;

/** The 360 x 180 sphere has 15 degree quads. Increase these if lines in your video look wavy. */
  public static int DEFAULT_SPHERE_ROWS = 50;
  public static int DEFAULT_SPHERE_COLUMNS = 50;

/** Tilt Placeholder as instructions how to use the VR Player */
  public static boolean SHOW_PLACEHOLDER = false;


  public VideoPlayer360Plugin() {

  }

  public VideoPlayer360Plugin(Context context) {
    this.context = context;
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "innov.lab/video_player_360");
    channel.setMethodCallHandler(new VideoPlayer360Plugin(flutterPluginBinding.getApplicationContext()));
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "innov.lab/video_player_360");
    channel.setMethodCallHandler(new VideoPlayer360Plugin(registrar.context()));
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

      if (call.method.equals("playvideo")) {

          /* Parameters to be set in Flutter when calling video_360 library */
          if (call.argument("video_url") != null) {
            VIDEO_URL = call.argument("video_url");
          }
          SPHERE_RADIUS_METERS = call.argument("radius");
          DEFAULT_SPHERE_VERTICAL_DEGREES = call.argument("verticalFov");
          DEFAULT_SPHERE_HORIZONTAL_DEGREES = call.argument("horizontalFov");
          DEFAULT_SPHERE_ROWS = call.argument("rows");
          DEFAULT_SPHERE_COLUMNS = call.argument("columns");
          SHOW_PLACEHOLDER = call.argument("showPlaceholder");

          Intent i = new Intent(context, VideoActivity.class);
          i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

          context.startActivity(i);

          result.success(new HashMap<>().put("result", "success"));
      } else {
          result.notImplemented();
      }
   }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
