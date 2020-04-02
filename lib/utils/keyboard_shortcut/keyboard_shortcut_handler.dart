import 'package:flutter/cupertino.dart';

class KeyboardShortcutHandler{

}


class KeyboardMapEvent{
  KeyboardMapEvent(this.name, this.keys);
  final String name;
  final List<String> keys;
}


var OPEN_SEARCH = KeyboardMapEvent("open search", const ["cmd", "f"]);



class ShortcutHandler{
  ShortcutHandler(this.key, {this.action});
  String key;
  Function action;
}