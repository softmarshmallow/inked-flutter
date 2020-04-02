import 'package:flutter/widgets.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/screen/development/development_landing_screen.dart';
import 'package:inked/screen/development/firestore_test_screen.dart';
import 'package:inked/screen/development/socketio_development_screen.dart';
import 'package:inked/screen/filter_create_screen.dart';
import 'package:inked/screen/filter_settings_screen.dart';
import 'package:inked/screen/filter_testing_screen.dart';
import 'package:inked/screen/saved_news_screen.dart';
import 'package:inked/screen/search_screen.dart';
import 'package:inked/screen/spam_or_not_screen.dart';

Map<String, WidgetBuilder> buildRoutes(BuildContext context){
  return {
    ContentDetailScreen.routeName: (context) => ContentDetailScreen(),
    SavedNewsScreen.routeName: (context) => SavedNewsScreen(),
    FilterSettingsScreen.routeName: (context) => FilterSettingsScreen(),
    FilterCreateScreen.routeName: (context) => FilterCreateScreen(),
    FilterTestingScreen.routeName: (context) => FilterTestingScreen(),
    SpamOrNotScreen.routeName: (context) => SpamOrNotScreen(),
    SearchScreen.routeName: (context) => SearchScreen(),

    // region development
    DevelopmentLandingScreen.routeName: (context) => DevelopmentLandingScreen(),
    FirestoreTestScreen.routeName: (context) => FirestoreTestScreen(),
    SocketioDevelopmentScreen.routeName: (context) => SocketioDevelopmentScreen(),
    // endregion
  };
}

