import 'package:flutter/material.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/screens/Email.dart';
import 'package:qr_code/screens/Message.dart';
import 'package:qr_code/screens/Phone.dart';
import 'package:qr_code/screens/ResEmail.dart';
import 'package:qr_code/screens/ResUrl.dart';
import 'package:qr_code/screens/ResWifi.dart';
import 'package:qr_code/screens/Textt.dart';
import 'package:qr_code/screens/Url.dart';
import 'package:qr_code/screens/Wifi.dart';
import 'package:qr_code/screens/history.dart';
import 'package:qr_code/screens/homePage.dart';
import 'package:qr_code/screens/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
