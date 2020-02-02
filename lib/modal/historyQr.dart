import 'dart:convert';

import 'package:flutter/services.dart';

class HistoryQr {
  String title;
  dynamic body;
  int time;
  int type;

  HistoryQr({this.title, this.body, this.time, this.type});

  HistoryQr.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    time = json['time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['time'] = this.time;
    data['type'] = this.type;
    return data;
  }
}

Future<List<HistoryQr>> loadAsset(String name) async {
  String jsonString = await rootBundle.loadString('assets/$name.json');
  dynamic jsonParser = jsonDecode(jsonString);
  List<HistoryQr> list = [];
  jsonParser.forEach((v) {
    list.add(new HistoryQr.fromJson(v));
  });
  return list;
}
