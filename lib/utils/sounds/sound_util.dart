import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:inked/data/remote/lite_connector.dart';

AudioPlayer audioPlayer = AudioPlayer();

List<String> _played = [];
playOnceInLifetime(String id, String file) async {
  if (!_played.contains(id)) {
    if (Platform.isWindows || Platform.isLinux) {
      LiteAppConnector().alertOnLiteApp(id);
      print("played sound $file -> via lite app");
    }  else{
      var res = await audioPlayer.play(file);
      print("played sound $file -> $res");
    }
    _played.add(id);
  }
}
