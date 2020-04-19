import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:inked/screen/development/api_test.dart';
import 'package:inked/screen/development/firestore_test_screen.dart';
import 'package:inked/screen/development/socketio_development_screen.dart';
import 'package:inked/screen/development/tab_bar_demo.dart';
import 'package:inked/screen/filters/filter_testing_screen.dart';
import 'package:inked/utils/constants.dart';

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
                var res = await audioPlayer.play(SOUND_TONE_2_URL);
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
                Navigator.of(context)
                    .pushNamed(SocketioDevelopmentScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(Icons.filter_list),
              title: Text('filter testing'),
              onTap: () {
                Navigator.of(context).pushNamed(FilterTestingScreen.routeName);
              },
            ),
            ListTile(
              title: Text('tab bar'),
              onTap: () {
                Navigator.of(context).pushNamed(TabBarDemoScreen.routeName);
              },
            ),
            ListTile(
              title: Text('api tests'),
              onTap: () {
                Navigator.of(context).pushNamed(ApiTestScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
