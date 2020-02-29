
import 'package:eventsource/eventsource.dart';
import 'package:inked/data/remote/base.dart';
import 'package:web_socket_channel/html.dart';
import 'package:http/browser_client.dart' as http;

class RealtimeNewsReceiver{

  // region
  static final RealtimeNewsReceiver _singleton = RealtimeNewsReceiver._internal();
  factory RealtimeNewsReceiver() {
    return _singleton;
  }
  RealtimeNewsReceiver._internal();
  // endregion

  final channel = HtmlWebSocketChannel.connect('ws://$server/ws/news/');
  Future<EventSource> eventSource = EventSource.connect("http://$server/api/events/",client: http.BrowserClient());

//  final sseChannel =
//  a() async {
//    var a  = await eventSource;
//  }

  close(){
    channel.sink.close();
  }
//
//  _builder(){
//    channel.stream.listen((data){
//      print(data);
//    }).onError((e){
//
//    });
//
//
//    StreamBuilder(
//      stream: channel.stream,
//      builder: (context, snapshot) {
//        return Text(snapshot.hasData ? '${snapshot.data}' : '');
//      },
//    );
//  }
}
