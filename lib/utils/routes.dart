import 'package:flutter/widgets.dart';
import 'package:inked/screen/content_detail_screen.dart';

Map<String, WidgetBuilder> buildRoutes(BuildContext context){
  return {
    ContentDetailScreen.routeName: (context) => ContentDetailScreen(),
  };
}

