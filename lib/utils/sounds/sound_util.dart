import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

List<String> _played = [];
playOnceInLifetime(String id, String file) async {
  if (!_played.contains(id)) {
    var res = await audioPlayer.play(file);
    print("played sound $file -> $res");
    _played.add(id);
  }
}
