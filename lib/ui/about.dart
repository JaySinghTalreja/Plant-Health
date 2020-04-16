import 'package:flutter/material.dart';


class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end:  Alignment.topRight,
                colors:[
                  Colors.green,
                  Color.fromRGBO(108,211,115, 30),
                  Colors.lightGreen,
                ],
              ),
              image: DecorationImage(
                image: AssetImage("assets/AL.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}