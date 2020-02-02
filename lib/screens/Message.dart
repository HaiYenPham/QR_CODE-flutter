import 'package:flutter/material.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/utils/share_pre.dart';

class Message extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Message();
  }
}

class _Message extends State<Message> {
  bool isHide = false;
  Result res;
  final phoneNumberController = TextEditingController();
  final contentController = TextEditingController();
  List<HistoryQr> listHistory = [];
  @override
  void initState() {
    SharedPreferencesUtils.getListData(KEY_HISTORY, (result) {
      listHistory = result;
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
                      Icons.message,
                      color: Colors.lightBlueAccent,
                    ),
                    title: Text(
                      "Message",
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
                  keyboardType: TextInputType.number,
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: contentController,
                  maxLength: 100,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Content",
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
                        createSMS(
                          phoneNumberController.text,
                          contentController.text,
                        ).then((value) {
                          setState(() {
                            isHide = false;
                            res = value;
                            //print(res);
                            if (res.success) {
                              HistoryQr qr = HistoryQr(
                                  time: DateTime.now().millisecondsSinceEpoch,
                                  title: contentController.text,
                                  type: TYPE_SMS,
                                  body: {
                                    "smsNumber": phoneNumberController.text,
                                    "smsContent": contentController.text,
                                    "contentType": "sms"
                                  });
                              listHistory.add(qr);
                              SharedPreferencesUtils.setListData(
                                  KEY_HISTORY, listHistory);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateOK(
                                    url: res.qrImage,
                                    type: TYPE_SMS,
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
