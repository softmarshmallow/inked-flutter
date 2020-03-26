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
  String message = "";

  @override
  void initState() {
    super.initState();
    IO.Socket socket = IO.io('http://localhost:3001/client', <String, dynamic>{
//      'transports': ['websocket'],
    });
    socket.on('connect', (_) {
      print('connect');
      socket.emitWithAck('mocknews', '', ack:(d){
        print(d);
        setState(() {
          message = d;
        });
      });
      socket.on('feed', (data) {
        print(data);
        setState(() {
          message = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('socket io'),
      ),
      body: Text(message),
    );
  }
}
