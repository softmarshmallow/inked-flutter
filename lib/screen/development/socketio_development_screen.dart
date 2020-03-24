import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketioDevelopmentScreen extends StatefulWidget {
  static const routeName = "/development/socketio";
  SocketioDevelopmentScreen({Key key}) : super(key: key);

  @override
  _SocketioDevelopmentScreenState createState() =>
      _SocketioDevelopmentScreenState();
}

class _SocketioDevelopmentScreenState extends State<SocketioDevelopmentScreen> {


  @override
  void initState() {
    super.initState();
    IO.Socket socket = IO.io('http://13.209.232.176:3001', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('connect', (_) {
      print('connect');
      socket.emit('my other event', 'test');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('socket io'),),);
  }
}