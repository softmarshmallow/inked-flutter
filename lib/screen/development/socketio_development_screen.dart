import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inked/data/model/news_receive.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketioDevelopmentScreen extends StatefulWidget {
  static const routeName = "/development/socketio";

  SocketioDevelopmentScreen({Key key}) : super(key: key);

  @override
  _SocketioDevelopmentScreenState createState() =>
      _SocketioDevelopmentScreenState();
}

class _SocketioDevelopmentScreenState extends State<SocketioDevelopmentScreen> {
  NewsReceiveEvent data;

  @override
  void initState() {
    super.initState();
    IO.Socket socket = IO.io('http://13.209.232.176:3001/client', <String, dynamic>{
//      'transports': ['websocket'],
    });
    socket.on('connect', (_) {
      print("socket io client connected");
    });

    socket.on("news", (event) {
      event = NewsReceiveEvent.fromJson({
        "data": event["data"],
        "type": event["type"]
      });
      setState(() {
        this.data = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('socket io'),
      ),
      body: data != null ? Text("${data.type} :: ${data.data.title}") : SizedBox.shrink(),
    );
  }
}
