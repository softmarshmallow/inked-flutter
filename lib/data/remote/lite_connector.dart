import 'package:socket_io_client/socket_io_client.dart' as IO;
IO.Socket socket = IO.io('http://13.209.232.176:3001/client', <String, dynamic>{
  'transports': ['websocket'],
});

class LiteAppConnector{

  // region singleton
  static final LiteAppConnector _singleton = LiteAppConnector._internal();

  factory LiteAppConnector() {
    socket.connect();
    socket.on("connect", (data)  {
      print("lite - app connected");
    });
    return _singleton;
  }

  LiteAppConnector._internal();

  // endregion

  alertOnLiteApp(String id){
    socket.emit('alert', id);
  }
}




//
//class LiteAppConnectorApi {
//
//
//
//
//}