# video_player_360

A Flutter plugin to stream 360° videos on iOS and Android

## Getting Started

This is a Flutter plugin to play 360° videos via a remote URL. 

The iOS player uses the open source [Google VR SDK for iOS](https://github.com/googlevr/gvr-ios-sdk)

The Android player uses the open source [Google VR SDK for Android](https://github.com/googlevr/gvr-android-sdk)

## Installation
Add video_player_360: ^0.1.3 in your pubspec.yaml dependencies.

## How to use #
importing the library:
``` dart
import 'package:video_player_360/video_player_360.dart';
```
play video:
``` dart
await VideoPlayer360.playVideoURL("ENTER_360_VIDEO_URL_HERE");
```