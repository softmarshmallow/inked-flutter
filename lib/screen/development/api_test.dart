import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inked/data/remote/base.dart';
import 'package:inked/utils/constants.dart';
import 'package:retrofit/http.dart';

class ApiTestScreen extends StatefulWidget {
  static const routeName = "development/api/test";

  @override
  State<StatefulWidget> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> routes = {
      "development/search": "GET",
      "development/search/history": "POST",
      "news/recent": "GET",
      "filter/news/terms": "GET"
    };

    return Scaffold(
        appBar: AppBar(
          title: Text("api test"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemBuilder: (c, i) {
                  var key = routes.keys.toList()[i];
                  var value = routes[key];
                  return ListTile(
                      title: Text("[${value}] ${key}"),
                      onTap: () {
                        RemoteApiManager()
                            .getDio()
                            .request(
                              key,
                              options: Options(method: value),
                            )
                            .then((value) {
                          print("dev - api value is.. $value");
                        });
                      });
                },
                itemCount: routes.length,
                shrinkWrap: true,
              ),
            ],
          ),
        ));
  }
}
