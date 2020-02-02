import 'package:flutter/material.dart';
import 'package:qr_code/screens/Email.dart';
import 'package:qr_code/screens/Message.dart';
import 'package:qr_code/screens/Phone.dart';
import 'package:qr_code/screens/Textt.dart';
import 'package:qr_code/screens/Url.dart';
import 'package:qr_code/screens/Wifi.dart';

class Create extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Create();
  }
}

final List<Widget> _listScreen = [
  Url(),
  Textt(),
  Email(),
  Wifi(),
  Phone(),
  Message()
];

class _Create extends State<Create> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<String> _listCreate = [
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
          ListView.builder(
            itemCount: _listCreate.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => _listScreen[index],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        _listIcon[index],
                        color: Colors.lightBlueAccent,
                      ),
                      title: Text(
                        _listCreate[index],
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
              );
            },
          ),
        ],
      ),
    );
  }
}
