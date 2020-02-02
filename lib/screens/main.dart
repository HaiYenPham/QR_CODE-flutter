import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/api/endpoints.dart';
import 'package:qr_code/modal/result.dart';
import 'package:qr_code/screens/create.dart';
import 'package:qr_code/screens/history.dart';
import 'package:qr_code/screens/homePage.dart';
import 'package:qr_code/screens/setting.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  Result result;
  var pageIndex = 0;
  void onPageChanged(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageView(
          physics: BouncingScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[HomePage(), Create(), History(), Setting()]),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: pageIndex,
        showElevation: true,
        itemCornerRadius: 8,
        onItemSelected: (index) => setState(() {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200), curve: Curves.ease);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.scanner),
            title: Text(
              'Scan',
              style: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
            activeColor: Colors.red,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.create),
            title: Text(
              'Create',
              style: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
            activeColor: Colors.purpleAccent,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.watch_later),
            title: Text(
              'History',
              style: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
            activeColor: Colors.pink,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text(
              'Setting',
              style: TextStyle(
                fontFamily: 'Sans',
                fontWeight: FontWeight.bold,
              ),
            ),
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
