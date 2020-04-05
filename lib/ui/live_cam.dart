import 'package:flutter/material.dart';
class LiveCam extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _LiveCamState extends State<LiveCam> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text("Live Camera");
      ),
    );
  }
}