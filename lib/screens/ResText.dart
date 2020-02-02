import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:date_format/date_format.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/utils/share_pre.dart';

class ResText extends StatefulWidget {
  int time;
  String content;
  ResText({this.content, this.time});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ResText();
  }
}

class _ResText extends State<ResText> {
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
          "Text",
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
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.text_fields,
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  width: width - 20,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.content.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sans',
                        fontSize: 20,
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
                child: GestureDetector(
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
                    width: width - 20,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.green,
                          ),
                          width: 150,
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
                                "Copy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Sans',
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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
