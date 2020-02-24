
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class RealtimeNewsReceiver{

  // region
  static final RealtimeNewsReceiver _singleton = RealtimeNewsReceiver._internal();
  factory RealtimeNewsReceiver() {
    return _singleton;
  }
  RealtimeNewsReceiver._internal();
  // endregion

  final channel = IOWebSocketChannel.connect('ws://localhost:8000/ws/chat/room');

  send(String message){
    channel.sink.add({"message": message});
  }

  close(){
    channel.sink.close();
  }

  _builder(){
    StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }
}
