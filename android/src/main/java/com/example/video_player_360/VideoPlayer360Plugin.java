package com.example.video_player_360;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;

import androidx.annotation.NonNull;

import com.example.video_player_360.videoplayer.VideoActivity;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** VideoPlayer360Plugin */
public class VideoPlayer360Plugin implements FlutterPlugin, MethodCallHandler {
  private Context context;
  public static String urlVideo;


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

          urlVideo = call.argument("video_url");

          Intent i = new Intent(context, VideoActivity.class);
          i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

          context.startActivity(i);
          result.success("loading video");
      } else {
          result.notImplemented();
      }
   }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
