import 'package:audioplayers/audioplayers.dart';

AudioPlayer audioPlayer = AudioPlayer();

const List<String> _played = [];
playOnceInLifetime(String id, String file) async {
  if (!_played.contains(id)) {
    await audioPlayer.play(file);
  }
}
