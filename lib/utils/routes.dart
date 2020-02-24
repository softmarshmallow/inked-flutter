import 'package:flutter/widgets.dart';
import 'package:inked/screen/content_detail_screen.dart';
import 'package:inked/screen/filter_settings_screen.dart';

Map<String, WidgetBuilder> buildRoutes(BuildContext context){
  return {
    ContentDetailScreen.routeName: (context) => ContentDetailScreen(),
    FilterSettingsScreen.routeName: (context) => FilterSettingsScreen(),
  };
}

