import 'package:flutter/material.dart';
import 'package:inked/dialogs/search_dialog.dart';
import 'package:inked/utils/routes.dart';
import 'package:inked/widget/content_detail.dart';
import 'package:inked/widget/main_drawer.dart';
import 'package:inked/widget/news_list.dart';
import 'package:inked/widget/position_news_content_holder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
      home: MyHomePage(title: 'Inked'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            NewsListView(),
            PositionedNewsContentHolder()
          ],
        ));
  }

  _onSearchPressed() {
    showDialog(
        context: context, builder: (BuildContext context) => SearchDialog());
  }
}
