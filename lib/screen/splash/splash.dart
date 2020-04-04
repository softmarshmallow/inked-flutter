import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/blocs/livenewslist/bloc.dart';
import 'package:inked/data/repository/news_filter_repositry.dart';
import 'package:inked/main.dart';
import 'package:inked/utils/constants.dart';
import 'package:inked/utils/sounds/sound_util.dart';

class Splash extends StatefulWidget {
  static const routeName = "/splash";

  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _SplashState() {
    initFirebaseWeb();
    playOnceInLifetime("spash", SOUND_TONE_1_URL);
    loadEnv().then((value) {
      NewsFilterRepository().seed();
      moveHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  moveHome() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (context) => NewsListBloc(),
        child: HomeScreen(title: "inked"),
      );
    }));
  }
}

Future<void> loadEnv() async {
  await DotEnv().load('.env');
}

initFirebaseWeb() {
  // FIXME does not work via dart, works in html script -> https://github.com/FirebaseExtended/flutterfire/issues/2204
}
