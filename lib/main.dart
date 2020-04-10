import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inked/blocs/livenewslist/bloc.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:inked/dialogs/search_dialog.dart';
import 'package:inked/screen/search_screen.dart';
import 'package:inked/screen/splash/splash.dart';
import 'package:inked/utils/filters/utils.dart';
import 'package:inked/utils/routes.dart';
import 'package:inked/widget/main_app_bar.dart';
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
        darkTheme: ThemeData.dark(),
        routes: buildRoutes(context),
        home: Splash());
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
  NewsApi api;
  MainTabsType selectedTap = MainTabsType.EXCLUDE_SPAM;
  initState() {
    super.initState();
    bloc = BlocProvider.of<NewsListBloc>(context);
    api = NewsApi(RemoteApiManager().getDio());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListBloc, NewsListState>(builder: (context, state) {
      return DefaultTabController(
        length: MainTabsType.values.length,
        initialIndex: selectedTap.index,
        child: Scaffold(
          appBar: MainAppBar(
            onSearchPressed: _onSearchPressed,
            onTabTap: _onTabTap,
          ),
          drawer: buildMainDrawer(context),
          body: _buildMasterDetailResponsive(),
          floatingActionButton: _buildFab(context, state),
        ),
      );
    });
  }

  Widget _buildMasterDetailResponsive() {
    bool Function(News) filter;
    switch (selectedTap){
      case MainTabsType.ALL:
        filter = null;
        break;
      case MainTabsType.EXCLUDE_SPAM:
        filter = (n) => !n.meta.isSpam;
        break;
      case MainTabsType.ONLY_HITS:
        filter = (n){
          if (n.filterResult != null && n.filterResult.matched) {
            if (shouldDisplayOnHits(n.filterResult.action)) {
              return true;
            }
          }
          return false;
        };
        break;
    }
    return Stack(
      children: <Widget>[LiveNewsListView(api: api, filterNews: filter,), PositionedNewsContentHolder()],
    );
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

  _onTabTap(MainTabsType tab){
    setState(() {
      selectedTap = tab;
    });
  }

  _openSearchDialog() {
    Navigator.of(context).pushNamed(SearchScreen.routeName);
//    showDialog(
//        context: context, builder: (BuildContext context) => SearchDialog());
  }
}
