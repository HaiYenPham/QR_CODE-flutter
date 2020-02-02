import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/utils/share_pre.dart';

class Textt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Textt();
  }
}

class _Textt extends State<Textt> {
  final myController = TextEditingController();
  Result res;
  bool isHide = false;
  List<HistoryQr> listHistory = [];
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferencesUtils.getListData(KEY_HISTORY, (result) {
      listHistory = result;
      //print(listHistory.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          "Create",
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
                      "Text",
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
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: myController,
                  maxLength: 1000,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Text",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide(),
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
                right: (width - 100) / 2,
                child: Center(
                  child: Container(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isHide = true;
                        });
                        createText(myController.text).then((value) {
                          setState(() {
                            isHide = false;
                            res = value;
                            if (res.success) {
                              HistoryQr qr = HistoryQr(
                                  time: DateTime.now().millisecondsSinceEpoch,
                                  type: TYPE_TEXT,
                                  title: myController.text,
                                  body: {
                                    "plainText": myController.text,
                                    "contentType": "text"
                                  });
                              listHistory.add(qr);
                              SharedPreferencesUtils.setListData(
                                  KEY_HISTORY, listHistory);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateOK(
                                    url: res.qrImage,
                                    type: TYPE_TEXT,
                                    time: DateTime.now().millisecondsSinceEpoch,
                                  ),
                                ),
                              );
                            } else {
                              //alert
                            }
                          });
                        });
                      },
                      color: Colors.white,
                      iconSize: 80,
                      icon: Icon(Icons.check_box),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isHide
              ? Positioned.fill(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
