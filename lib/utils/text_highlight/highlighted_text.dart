


import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget buildTextFromEm(String emString, TextStyle style){
  emString = emString.replaceAll("<em>", " _**");
  emString = emString.replaceAll("</em>", "**_ ");
  return Markdown(data: emString, shrinkWrap: true,);
}