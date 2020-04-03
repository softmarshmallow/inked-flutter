import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:inked/screen/development/firestore_test_screen.dart';
import 'package:inked/screen/development/socketio_development_screen.dart';

class DevelopmentLandingScreen extends StatefulWidget {
  static const routeName = "development/";

  DevelopmentLandingScreen({Key key}) : super(key: key);

  @override
  _DevelopmentLandingScreenState createState() =>
      _DevelopmentLandingScreenState();
}

class _DevelopmentLandingScreenState extends State<DevelopmentLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("development"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('dev - sound'),
              onTap: () async {
                AudioPlayer audioPlayer = AudioPlayer();
                var res = await audioPlayer.play(
                    "https://freesound.org/data/previews/147/147597_2173181-lq.mp3");
                print(res);
//                var eres = await audioPlayer.play("assets/beep.mp3", isLocal: true);
//                print(eres);
              },
            ),
            ListTile(
              title: Text('dev - firestore'),
              onTap: () {
                Navigator.of(context).pushNamed(FirestoreTestScreen.routeName);
              },
            ),

            ListTile(
              title: Text('dev - socket io'),
              onTap: () {
                Navigator.of(context).pushNamed(SocketioDevelopmentScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
