
import 'package:flutter/cupertino.dart';

class TokenFilter {
  TokenFilter({@required this.token, @required this.type, @required this.scope});
  String token;
  FilterType type;
  FilterScope scope;
}


enum FilterType{
  Ignore,
  Notify
}

enum FilterScope{
  Title,
  Body
}