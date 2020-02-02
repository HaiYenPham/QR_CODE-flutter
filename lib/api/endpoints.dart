import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/result.dart';

Future<Result> createURL(url) async {
  Map data = {"content": url, "contentType": "url"};
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createText(text) async {
  Map data = {"plainText": text, "contentType": "text"};
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createEmail(address, title, content) async {
  Map data = {
    "emailTabE": address,
    "titleTabE": title,
    "contentTabE": content,
    "contentType": "email"
  };
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createWifi(name, pass, wifiType) async {
  Map data = {
    "ssid": name,
    "passWifi": pass,
    "encrypWifi": wifiType,
    "contentType": "wifi"
  };
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createPhone(phonenumber) async {
  Map data = {"phoneNumber": phonenumber, "contentType": "phone"};
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createSMS(phonenumber, content) async {
  Map data = {
    "smsNumber": phonenumber,
    "smsContent": content,
    "contentType": "sms"
  };
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

Future<Result> createbyData(dt) async {
  Map data = dt;
  var body = json.encode(data);
  var response = await http.post(URL,
      headers: {"Content-Type": "application/json"}, body: body);
  final jsonData = json.decode(response.body);
  final result = Result.fromJson(jsonData);
  return result;
}

// Future<List<Result>> getData() async {
//   var response =
//       await http.get('http://data.aib.babylover.me/guide/darkriddle/data.json');
//   print(response.body);
//   final jsonData = json.decode(response.body);
//   List<Result> arr = jsonData.map((e){
//     return Result.fromJson(e);
//   });
//   jsonData.forEach((e) {
//     arr.add(Result.fromJson(e));
//   });
//   return arr;
//   // final result = Result.fromJson(jsonData);
//   // return result;
// }
