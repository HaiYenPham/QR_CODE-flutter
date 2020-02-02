import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/screens/ResEmail.dart';
import 'package:qr_code/screens/ResMessage.dart';
import 'package:qr_code/screens/ResPhone.dart';
import 'package:qr_code/screens/ResText.dart';
import 'package:qr_code/screens/ResUrl.dart';
import 'package:qr_code/screens/ResWifi.dart';
import 'package:qr_code/utils/share_pre.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:qr_code_tools/qr_code_tools.dart';
import 'package:image_picker/image_picker.dart';
import 'package:verbal_expressions/verbal_expressions.dart';

const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int currentIndex = 0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  var flashState = flash_on;
  var cameraState = front_camera;
  QRViewController qrcontroller;
  List<HistoryQr> listHistory = [];
  @override
  void initState() {
    SharedPreferencesUtils.getListData(KEY_HISTORY, (result) {
      listHistory = result;
    });
    super.initState();
  }

  Future<File> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future decode(String file) async {
    String data = await QrCodeToolsPlugin.decodeFrom(file);
    //print(data);
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.qrcontroller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("===============");
      print(scanData);
      qrText = scanData;
      if (qrText != "") {
        var regexURL = VerbalExpression()
          ..startOfLine()
          ..then("http")
          ..maybe("s")
          ..then("://")
          ..maybe("www.")
          ..anythingBut(" ")
          ..endOfLine();
        var regexEMAIL = VerbalExpression()
          ..startOfLine()
          ..then("MATMSG:")
          ..anythingBut(" ")
          ..then("TO:")
          ..anythingBut(" ")
          ..then(";SUB:")
          ..anythingBut(" ")
          ..then(";BODY:")
          ..anythingBut(" ")
          ..then(";")
          ..endOfLine();
        var regexWIFI = VerbalExpression()
          ..startOfLine()
          ..then("WIFI:")
          ..anythingBut(" ")
          ..then("T:")
          ..anything()
          ..then(";S:")
          ..anything()
          ..then(";P:")
          ..anything()
          ..then(";;")
          ..endOfLine();
        var regexPHONE = VerbalExpression()
          ..startOfLine()
          ..then("TEL:")
          ..anything()
          ..endOfLine();
        var regexSMS = VerbalExpression()
          ..startOfLine()
          ..then("smsto:")
          ..anythingBut(" ")
          ..then(":")
          ..anythingBut(" ")
          ..endOfLine();
        if (regexURL.hasMatch(qrText)) {
          HistoryQr qr = HistoryQr(
              time: DateTime.now().millisecondsSinceEpoch,
              title: qrText,
              body: {"content": qrText, "contentType": "url"},
              type: TYPE_URL);
          listHistory.add(qr);
          SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResUrl(
                url: qrText,
                type: TYPE_URL,
                time: DateTime.now().millisecondsSinceEpoch,
              ),
            ),
          ).then((result) {
            qrcontroller.resumeCamera();
          });
          qrcontroller.pauseCamera();
        } else {
          if (regexEMAIL.hasMatch(qrText)) {
            var startAddress = qrText.indexOf("TO:") + 3;
            var endAddress = qrText.indexOf(";SUB:");
            var address = qrText.substring(startAddress, endAddress);
            var startTitle = endAddress + 5;
            var endTitle = qrText.indexOf(";BODY:");
            var title = qrText.substring(startTitle, endTitle);
            var startContent = endTitle + 6;
            var endContent = qrText.lastIndexOf(";");
            var content = qrText.substring(startContent, endContent);
            var time = DateTime.now().millisecondsSinceEpoch;
            HistoryQr qr = HistoryQr(
                time: time,
                title: address,
                body: {
                  "emailTabE": address,
                  "titleTabE": title,
                  "contentTabE": content,
                  "contentType": "email"
                },
                type: TYPE_EMAIL);
            listHistory.add(qr);
            SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResEmail(
                  to: address,
                  title: title,
                  content: content,
                  time: time,
                ),
              ),
            ).then((result) {
              qrcontroller.resumeCamera();
            });
            qrcontroller.pauseCamera();
          } else {
            if (regexWIFI.hasMatch(qrText)) {
              //WIFI:T:WEP;S:a;P:aaaaaaaaa;;
              var startType = 7;
              var endType = qrText.indexOf(";S:");
              var type = qrText.substring(startType, endType);
              var startName = endType + 3;
              var endName = qrText.indexOf(";P:");
              var name = qrText.substring(startName, endName);
              var startPassword = endName + 3;
              var endPassword = qrText.lastIndexOf(";;");
              var password = qrText.substring(startPassword, endPassword);
              var time = DateTime.now().millisecondsSinceEpoch;
              HistoryQr qr = HistoryQr(
                  time: time,
                  title: name,
                  body: {
                    "ssid": name,
                    "passWifi": password,
                    "encrypWifi": type,
                    "contentType": "wifi"
                  },
                  type: TYPE_WIFI);
              listHistory.add(qr);
              SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResWifi(
                    type: type,
                    name: name,
                    password: password,
                    time: time,
                  ),
                ),
              ).then((result) {
                qrcontroller.resumeCamera();
              });
              qrcontroller.pauseCamera();
            } else {
              if (regexPHONE.hasMatch(qrText)) {
                var phoneNumber = qrText.substring(4);
                var time = DateTime.now().millisecondsSinceEpoch;
                HistoryQr qr = HistoryQr(
                    time: time,
                    title: phoneNumber,
                    body: {"phoneNumber": phoneNumber, "contentType": "phone"},
                    type: TYPE_PHONE);
                listHistory.add(qr);
                SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResPhone(
                      phoneNumber: phoneNumber,
                      time: time,
                    ),
                  ),
                ).then((result) {
                  qrcontroller.resumeCamera();
                });
                qrcontroller.pauseCamera();
              } else {
                if (regexSMS.hasMatch(qrText)) {
                  var startPhone = 6;
                  var endPhone = qrText.lastIndexOf(":");
                  var phoneNumber = qrText.substring(startPhone, endPhone);
                  var content = qrText.substring(endPhone + 1);
                  var time = DateTime.now().millisecondsSinceEpoch;
                  HistoryQr qr = HistoryQr(
                      time: time,
                      title: content,
                      body: {
                        "smsNumber": phoneNumber,
                        "smsContent": content,
                        "contentType": "sms"
                      },
                      type: TYPE_SMS);
                  listHistory.add(qr);
                  SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResSMS(
                        phoneNumber: phoneNumber,
                        content: content,
                        time: time,
                      ),
                    ),
                  ).then((result) {
                    qrcontroller.resumeCamera();
                  });
                  qrcontroller.pauseCamera();
                } else {
                  var time = DateTime.now().millisecondsSinceEpoch;
                  HistoryQr qr = HistoryQr(
                      time: time,
                      title: qrText,
                      body: {"plainText": qrText, "contentType": "text"},
                      type: TYPE_TEXT);
                  listHistory.add(qr);
                  SharedPreferencesUtils.setListData(KEY_HISTORY, listHistory);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResText(
                        content: qrText,
                        time: time,
                      ),
                    ),
                  ).then((result) {
                    qrcontroller.resumeCamera();
                  });
                  qrcontroller.pauseCamera();
                }
              }
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    qrcontroller?.dispose();
    super.dispose();
  }

  _isFlashOn(String current) {
    return flash_on == current;
  }

  _isBackCamera(String current) {
    return back_camera == current;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                width: 75,
                height: 35,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        if (qrcontroller != null) {
                          qrcontroller.toggleFlash();
                          if (_isFlashOn(flashState)) {
                            setState(() {
                              flashState = flash_off;
                            });
                          } else {
                            setState(() {
                              flashState = flash_on;
                            });
                          }
                        }
                      },
                      child: Icon(
                        flashState != flash_off
                            ? Icons.flash_off
                            : Icons.flash_on,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                )),
            Text(
              "Scan",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Sans',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 35,
                      child: GestureDetector(
                        onTap: () {
                          getImage().then((image) {
                            decode(image.path);
                          });
                        },
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      child: GestureDetector(
                        onTap: () {
                          if (qrcontroller != null) {
                            qrcontroller.flipCamera();
                            if (_isBackCamera(cameraState)) {
                              setState(() {
                                cameraState = front_camera;
                              });
                            } else {
                              setState(() {
                                cameraState = back_camera;
                              });
                            }
                          }
                        },
                        child: Icon(
                          Icons.switch_camera,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.blue, Colors.white],
                begin: Alignment.topCenter,
              ))*/
            color: Colors.lightBlueAccent[100],
          ),
          Positioned.fill(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
