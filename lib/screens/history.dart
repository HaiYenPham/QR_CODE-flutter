import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/constants/constants.dart';
import 'package:qr_code/modal/historyQr.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/CreateOK.dart';
import 'package:qr_code/utils/share_pre.dart';

class History extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _History();
  }
}

class _History extends State<History> {
  final List<IconData> _listIcon = [
    Icons.link,
    Icons.text_fields,
    Icons.email,
    Icons.wifi,
    Icons.phone,
    Icons.message
  ];
  int currentIndex = 2;
  int _counter = 0;
  Result re_result;
  List<HistoryQr> listHistory = [];
  @override
  void initState() {
    SharedPreferencesUtils.getListData(KEY_HISTORY, (result) {
      setState(() {
        listHistory = result;
        //listHistory.forEach((f) => print(f.toJson()));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          "History",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: listHistory.length,
              itemBuilder: (context, index) {
                var date = new DateTime.fromMillisecondsSinceEpoch(
                    listHistory[listHistory.length - index - 1].time);

                return GestureDetector(
                  onTap: () {
                    createbyData(
                            listHistory[listHistory.length - index - 1].body)
                        .then((res) {
                      re_result = res;
                      if (re_result.success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateOK(
                              url: re_result.qrImage,
                              type: listHistory[listHistory.length - index - 1]
                                  .type,
                              time: listHistory[listHistory.length - index - 1]
                                  .time,
                            ),
                          ),
                        );
                      }
                    });
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        _listIcon[
                            listHistory[listHistory.length - index - 1].type -
                                1],
                        color: Colors.blueAccent,
                      ),
                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  listHistory[listHistory.length - index - 1]
                                      .title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
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
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  listHistory
                                      .removeAt(listHistory.length - index - 1);
                                  SharedPreferencesUtils.setListData(
                                      KEY_HISTORY, listHistory);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.blue[200],
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
