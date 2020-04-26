import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:plant_health/ui/about.dart';
import 'package:plant_health/ui/gallery_select.dart';
import 'package:plant_health/ui/live_cam.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

//--------->REFERENCE THE BOTTOM NAVIGATION BAR https://github.com/tunitowen/fancy_bottom_navigation<---------------

class _HomeScreenState extends State<HomeScreen> {

  int currentPage = 1;
  final List<Widget> _children = [
    new GallerySelect(),
    new LiveCam(),
    new About()
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      title: "Home Screen",


      theme: new ThemeData(
          primaryColor: Colors.lightGreen,
          primarySwatch: Colors.blue,
          accentColor: Colors.red),

          //Tu Remove the Debig Tag
      debugShowCheckedModeBanner: false,
      

      home: new Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
              TabData(iconData: Icons.image, title:"Gallery"),
              TabData(iconData: Icons.camera, title: "Live Cam"),
              TabData(iconData: Icons.person, title: "About")
          ],

          //Setting Defautl Screen To The Middle One
          initialSelection:1,

          //Function to Switch Between Screen
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),

        //List of Screen to Switch Between
        body: _children[currentPage],

      ),
    );
  }
}

/*
//Old Screen
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Home Screen",
      theme: new ThemeData(
          primaryColor: Colors.lightGreen,
          primarySwatch: Colors.blue,
          accentColor: Colors.red),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Home Screen",
            style: new TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: new Container(
          color: Colors.white,
          child: new Center(
            child: new Text(
              "Welcome to Home Screen",
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
*/