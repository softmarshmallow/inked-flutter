//import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inked/blocs/newslist/bloc.dart';
import 'package:inked/dialogs/search_dialog.dart';
import 'package:inked/screen/splash/splash.dart';
import 'package:inked/utils/routes.dart';
import 'package:inked/widget/main_drawer.dart';
import 'package:inked/widget/news_list.dart';
import 'package:inked/widget/position_news_content_holder.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  print("started application..");
  runApp(App());
}


class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inked inteligence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: buildRoutes(context),
      home: Splash()
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
  NewsListBloc bloc;

  initState() {
    super.initState();
    bloc = BlocProvider.of<NewsListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListBloc, NewsListState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: _onSearchPressed)
          ],
        ),
        drawer: buildMainDrawer(context),
        body: Stack(
          children: <Widget>[LiveNewsListView(), PositionedNewsContentHolder()],
        ),
        floatingActionButton: _buildFab(context, state),
      );
    });
  }

  Widget _buildFab(BuildContext context, NewsListState state) {
    if (state is! TopFocusState) {
      return FloatingActionButton(
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            bloc.add(TopFocusEvent());
          });
    }
    return SizedBox.shrink();
  }

  _onSearchPressed() {
    _openSearchDialog();
  }

  _openSearchDialog() {
    showDialog(
        context: context, builder: (BuildContext context) => SearchDialog());
  }
}
