import 'package:dio/dio.dart';
import 'package:eventsource/eventsource.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:web_socket_channel/html.dart';
import 'package:http/browser_client.dart' as http;

class RealtimeNewsReceiver {
  // region
  static final RealtimeNewsReceiver _singleton =
      RealtimeNewsReceiver._internal();

  factory RealtimeNewsReceiver() {
    return _singleton;
  }

  RealtimeNewsReceiver._internal();

  // endregion

  final channel = HtmlWebSocketChannel.connect('ws://$server/ws/news/');
  Future<EventSource> eventSource = EventSource.connect(
      "http://$server/api/events/",
      client: http.BrowserClient());

  static const _interval = 2000; // ms
  Stream<News> newsStream() async* {
    String lastNewsId;
    List<News> newRecents = [];
    var api = NewsApi(Dio());
    while (true) {
      await new Future.delayed(new Duration(milliseconds: _interval));
      var recents = await api.getLastNews();
      if (lastNewsId == null) {
        newRecents = recents;
      } else{
        newRecents = filterRecentById(recents, lastNewsId);
      }
      if (newRecents.length > 0) {
        print("newRecents ${newRecents.length}");
        lastNewsId = newRecents.first.id;
        for (var d in newRecents.reversed){
          yield d;
        }
      }
    }
  }

  List<News> filterRecentById(List<News> recents, String id){
    List<News> result = [];
    for(var r in recents){
      if (r.id == id) {
        break;
      }  else{
        result.add(r);
      }
    }
    return result;
  }
}
