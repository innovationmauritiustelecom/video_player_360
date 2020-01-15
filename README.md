# video_player_360

A Flutter plugin to stream 360° videos on iOS

## Getting Started

This is a Flutter plugin to play 360° videos via a URL. 

The iOS player uses the open source [HTY360Player](https://github.com/hanton/HTY360Player)

Android support coming soon.

## Installation
Add video_player_360: ^0.0.1 in your pubspec.yaml dependencies.

## How to use #
importing the library:
``` dart
import 'package:video_player_360/video_player_360.dart';
```
play video:
``` dart
await VideoPlayer360.playVideoURL("ENTER_360_VIDEO_URL_HERE");
```