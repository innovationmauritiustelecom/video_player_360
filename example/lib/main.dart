import 'package:flutter/material.dart';
import 'package:video_player_360/video_player_360.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('360 Video Player Flutter'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              await VideoPlayer360.playVideoURL(
                  "http://196.192.110.79:1935/test/videoplay/playlist.m3u8");
            },
            child: Text("Click to play Video URL"),
          ),
        ),
      ),
    );
  }
}
