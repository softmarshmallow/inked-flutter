


import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget buildTextFromEm(String emString, TextStyle style){
  emString = emString.replaceAll("<em>", " ***");
  emString = emString.replaceAll("</em>", "*** ");
  return Markdown(data: emString, shrinkWrap: true,);
}