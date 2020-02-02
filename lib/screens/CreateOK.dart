import 'dart:io';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:qr_code/utils/download_Image.dart';
import 'package:qr_code/utils/share_img.dart';

class CreateOK extends StatefulWidget {
  int type;
  int time;
  String url;
  CreateOK({this.url, this.type, this.time});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateOK();
  }
}

class _CreateOK extends State<CreateOK> {
  final List<String> _listType = [
    "Url",
    "Text",
    "Email",
    "Wifi",
    "Phone",
    "Message"
  ];
  final List<IconData> _listIcon = [
    Icons.link,
    Icons.text_fields,
    Icons.email,
    Icons.wifi,
    Icons.phone,
    Icons.message
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var date = DateTime.fromMillisecondsSinceEpoch(widget.time);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          _listType[widget.type - 1],
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
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 40,
              left: 10,
              right: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        _listIcon[widget.type - 1],
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
                FadeInImage.assetNetwork(
                  placeholder: 'assets/images/loading.gif',
                  image: widget.url,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        save_img(widget.url, context);
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.red,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Icon(
                              Icons.file_download,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Sans',
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var request =
                            await HttpClient().getUrl(Uri.parse(widget.url));
                        var response = await request.close();
                        Uint8List bytes =
                            await consolidateHttpClientResponseBytes(response);
                        await Share.file(
                            'ESYS AMLOG', 'amlog.jpg', bytes, 'image/jpg');
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.blueAccent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              Icons.share,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Sans',
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
