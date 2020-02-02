import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/modal/result.dart';
import 'package:url_launcher/url_launcher.dart';

class ResSMS extends StatefulWidget {
  String phoneNumber;
  String content;
  int time;
  ResSMS({this.phoneNumber, this.content, this.time});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResSMS();
  }
}

class _ResSMS extends State<ResSMS> {
  _launchSMS() async {
    if (await canLaunch('sms:${widget.phoneNumber}')) {
      await launch('sms:${widget.phoneNumber}');
    }
  }

  bool isHide = false;
  Result res;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var date = DateTime.fromMillisecondsSinceEpoch(widget.time);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          "Phone",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Sans',
            fontSize: 25,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height,
            color: Colors.lightBlueAccent[100],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.message,
                      color: Colors.lightBlueAccent,
                    ),
                    title: Text(
                      formatDate(date, [
                        dd,
                        '-',
                        mm,
                        '-',
                        yyyy,
                        '  -  ',
                        HH,
                        ':',
                        nn,
                        ':',
                        ss
                      ]),
                      style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Phone number:",
                  style: TextStyle(
                    fontFamily: 'Sans',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  width: width,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.phoneNumber.toString(),
                      style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "Content:",
                  style: TextStyle(
                    fontFamily: 'Sans',
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  width: width,
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.content.toString(),
                      style: TextStyle(
                        fontFamily: 'Sans',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Positioned(
                top: height - 250,
                right: 10,
                child: Container(
                  width: width - 20,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          ClipboardManager.copyToClipBoard(widget.phoneNumber)
                              .then(
                            (result) {
                              EdgeAlert.show(context,
                                  title: 'Copied to Clipboard',
                                  gravity: EdgeAlert.TOP,
                                  backgroundColor: Colors.green);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          width: (width - 32) / 2,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.content_copy,
                                size: 30,
                                color: Colors.white,
                              ),
                              Text(
                                "Phonenumber",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sans',
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ClipboardManager.copyToClipBoard(widget.content).then(
                            (result) {
                              EdgeAlert.show(context,
                                  title: 'Copied to Clipboard',
                                  gravity: EdgeAlert.TOP,
                                  backgroundColor: Colors.green);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          width: (width - 32) / 2,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.content_copy,
                                size: 30,
                                color: Colors.white,
                              ),
                              Text(
                                "Content",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sans',
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
