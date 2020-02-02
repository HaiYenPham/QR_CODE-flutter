import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/utils/share_pre.dart';
import 'package:url_launcher/url_launcher.dart';

class ResPhone extends StatefulWidget {
  String phoneNumber;
  int time;
  ResPhone({this.phoneNumber, this.time});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResPhone();
  }
}

class _ResPhone extends State<ResPhone> {
  _launchPhone() async {
    if (await canLaunch('tel:${widget.phoneNumber}')) {
      await launch('tel:${widget.phoneNumber}');
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
                      Icons.phone,
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
                  child: GestureDetector(
                    onTap: () {
                      _launchPhone();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                      ),
                      width: 200,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.phone,
                            size: 30,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Call",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Sans',
                                fontSize: 23,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
