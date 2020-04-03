import 'dart:async';

import 'package:dio/dio.dart';
import 'package:inked/data/model/news.dart';
import 'package:inked/data/model/news_receive.dart';
import 'package:inked/data/remote/news_api.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RealtimeNewsReceiver {
  // region
  static final RealtimeNewsReceiver _singleton =
      RealtimeNewsReceiver._internal();
  static NewsApi _api;
  static IO.Socket _socket;
  factory RealtimeNewsReceiver() {
     _api = NewsApi(Dio());
     _initiallyLoadNews();
     _listenSocketNewsEvents();
    return _singleton;
  }

  static _initiallyLoadNews() async {
    var recents = await _api.getLastNews();
    recents.reversed.forEach((element) {
      _controller.add(element);
    });
  }

  static void _listenSocketNewsEvents(){
    _socket = IO.io('http://13.209.232.176:3001/client', <String, dynamic>{
      'transports': ['websocket'],
    });
    _socket.on('connect', (_) {
      print("socket io client connected");
    });

    _socket.on("news", (event) {
//      print(event);
      event = NewsReceiveEvent.fromJson({
        "data": event["data"],
        "type": event["type"]
      });
      _controller.add(event.data);
    });
  }

  RealtimeNewsReceiver._internal();


  static StreamController<News> _controller = StreamController<News>();
  Stream<News> steam(){
    return _controller.stream;
  }

  // endregion
  static const _interval = Duration(seconds: 5, milliseconds: 0);
  Stream<News> newsStream() async* {
    String lastNewsId;
    List<News> newRecents = [];
    while (true) {
      var recents = await _api.getLastNews();
      if (lastNewsId == null) {
        newRecents = recents;
      } else{
        newRecents = filterRecentById(recents, lastNewsId);
      }
      if (newRecents.length > 0) {
        lastNewsId = newRecents.first.id;
        for (var d in newRecents.reversed){
          yield d;
        }
      }
//      sleep(_interval);
      await new Future.delayed(_interval);
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
