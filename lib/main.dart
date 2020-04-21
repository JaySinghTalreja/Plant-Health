import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plant_health/ui/home_screen.dart';
void main() => runApp(new MaterialApp(
  home: new SplashScreen(),
  debugShowCheckedModeBanner:false,
  title:'Plant Health',
  routes: <String, WidgetBuilder>{
    '/HomeScreen': (BuildContext context) => new HomeScreen()
  },
  )
);


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
  
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Container(
          child : new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('assets/loader2.gif', width: 200, height: 200,),
            ],
          ), 
        ),
      ),
    ); 
  }
}