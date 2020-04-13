import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_button/progress_button.dart';
class LiveCam extends StatefulWidget {
  @override
  _LiveCamState createState() => _LiveCamState();
}

class _LiveCamState extends State<LiveCam> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title:"Live Cam Screen"
      theme : new ThemeData(
        primaryColor: Colors.lightGreen,
        primarySwatch: Colors.blue,
        accentColor: Colors.red
        ),
          //Tu Remove the Debig Tag
        debugShowCheckedModeBanner: false,
        home : new Scaffold(
          body: Center(
            child: _image == null ? Text('No image selected.'): Image.file(_image),
          ),
          
          theme: new ThemeData(
              primaryColor: Colors.lightGreen,
              primarySwatch: Colors.blue,
              accentColor: Colors.red
          ),

          floatingActionButton : ProgressButton(
            child: Text("Get Image"),
            onPressed: getImage,
            buttonState: ButtonState.normal,
            backgroundColor: Theme.of(context).primaryColor,
            progressColor: Theme.of(context).primaryColor,
          ),

          /*floatingActionButton: FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),*/
        );
      );
  }
}