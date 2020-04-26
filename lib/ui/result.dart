import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String dataDisease;
  ResultScreen({Key key, @required this.dataDisease}) : super(key:key);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Center(
        child: new Column(
          children: <Widget>[
            SizedBox(height: 100),
            Text(
              "Disease Identified",
              style: TextStyle(fontSize: 40, fontFamily:"FutureSpore", color:Colors.lightGreen),
            ),
            SizedBox(height: 55),
            Text(
              widget.dataDisease,
              style: TextStyle(fontSize: 24, fontFamily: "BalooTamma", color: Colors.blueGrey),
            ),
            Divider(indent: 10.0,endIndent: 10.0,thickness: 2,),
          ],
        ),
      ),
    );
  }
}