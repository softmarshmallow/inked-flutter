import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/blocs/newslist/bloc.dart';
import 'package:inked/dialogs/search_dialog.dart';
import 'package:inked/utils/routes.dart';
import 'package:inked/widget/main_drawer.dart';
import 'package:inked/widget/news_list.dart';
import 'package:inked/widget/position_news_content_holder.dart';

void main(){
  loadEnv();
//  initFirebaseWeb();
  runApp(App());
}

Future<void> loadEnv() async {
  await DotEnv().load('.env');
}

initFirebaseWeb() {
  // FIXME does not work via dart, works in html script -> https://github.com/FirebaseExtended/flutterfire/issues/2204
//  String data = await DefaultAssetBundle.of(context).loadString("assets/firebase.json");
//  final jsonResult = json.decode(data);
//  var env = DotEnv().env;
//  print(env["apiKey"]);
//  if (apps.isEmpty) {
//    initializeApp(
//      apiKey: env['apiKey'],
//      authDomain: env['authDomain'],
//      databaseURL: env['databaseURL'],
//      projectId: env['projectId'],
//      storageBucket: env['storageBucket'],);
//  }
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: buildRoutes(context),
      home: BlocProvider(
        create: (context) => NewsListBloc(),
        child: HomeScreen(title: 'Inked'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: _onSearchPressed)
          ],
        ),
        drawer: buildMainDrawer(context),
        body: Stack(
          children: <Widget>[
            LiveNewsListView(),
            PositionedNewsContentHolder()
          ],
        ));
  }

  _onSearchPressed() {
    showDialog(
        context: context, builder: (BuildContext context) => SearchDialog());
  }
}
