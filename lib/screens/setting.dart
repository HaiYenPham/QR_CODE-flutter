import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Setting();
  }
}

class _Setting extends State<Setting> {
  final List<String> _listSetting = [
    "Rung",
    "Mở website tự động",
    "Giới thiệu",
    "Phiên bản"
  ];
  final List<IconData> _listIcon = [
    Icons.vibration,
    Icons.open_in_new,
    Icons.pageview,
    Icons.update
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          "Setting",
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
          GridView.count(
            crossAxisCount: 2,
            children: List<Widget>.generate(4, (index) {
              return GridTile(
                child: Card(
                  color: Colors.lightBlueAccent[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Icon(
                          _listIcon[index],
                          size: 50,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Text(
                            _listSetting[index],
                            style: TextStyle(
                              fontFamily: 'Sans',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
