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
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Text(
          widget.dataDisease,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}