import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_button/progress_button.dart';
import 'package:animated_widgets/animated_widgets.dart';
class LiveCam extends StatefulWidget {
  @override
  _LiveCamState createState() => _LiveCamState();
}

class _LiveCamState extends State<LiveCam> {
  //Image
  File _image;

  //Bool for Shake Animated Widget
  bool _enabled = true;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:"Live Cam Screen",
      //Theme for the current Screen
      theme : new ThemeData(
        primaryColor: Colors.lightGreen,
        primarySwatch: Colors.indigo,
        accentColor: Colors.lightGreen
      ),
        //Tu Remove the Debig Tag
      debugShowCheckedModeBanner: false,

      home : new Scaffold(
        body: Center(
          child: _image == null ? Text('No image selected.'): Image.file(_image),
        ),
        
        //Changed Icon Color inside FLoatingActionButton By Wraping the icon in an IconTheme & Elevated it using Padding from bottom over 20 pixels
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: new IconTheme(
              data: new IconThemeData(color: Colors.white), 
              child: new Icon(Icons.add_a_photo),
            ),
          ),
        ),
      ),
    );
  }
}

ShakeAnimatedWidget(
  enabled: this._enabled,
  duration: Duration(milliseconds: 1500),
  shakeAngle: Rotation.deg(z: 40),
  curve: Curves.linear,
  child: FloatingActionButton(
    onPressed: getImage,
    tooltip: 'Pick Image',
    child: new IconTheme(
      data: new IconThemeData(color: Colors.white), 
      child: new Icon(Icons.add_a_photo),
    ),
  ),
),
/*
*/

