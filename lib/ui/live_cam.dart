import 'dart:io' as Io;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//Additional Imports
import 'package:progress_button/progress_button.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//Imports for REST API 
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

class LiveCam extends StatefulWidget {
  @override
  _LiveCamState createState() => _LiveCamState();
}

class _LiveCamState extends State<LiveCam> {

  //Image
  Io.File _image;
  
  //API 
  final String predictCall = "http://127.0.0.1:8000/API/predict";

  //Bool for Shake Animated Widget
  bool _enabled = true;
  //var _imageLogo = new Image.asset('assets/noimageslogo.png');

  //Text Animation using Animated text kit
  var _imageLogo = new Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      //Commented this to make the text appear at center

      /*SizedBox(width: 20.0, height: 100.0),
      Text(
        "Be",
        style: TextStyle(fontSize: 43.0),
      ),
      SizedBox(width: 20.0, height: 100.0),
      */
      RotateAnimatedTextKit(
        onTap: () {
          print("Tap Event");
        },
        text: ["Welcome", "To", "Greenify", "Welcome", "To", "Greenify", "Welcome", "To", "Greenify"],
        textStyle: TextStyle(fontSize: 50.0,fontWeight: FontWeight.bold, fontFamily: "NeonClubMusic", color: Colors.lightGreen),
        textAlign: TextAlign.start,
        alignment: AlignmentDirectional.topStart // or Alignment.topLeft
      ),
    ],
  );

  //Function to Select Image and convert it into base64 format
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //Trial to Convert Image to Base64
    final bytes = image.readAsBytesSync();
    String img64 = base64Encode(bytes);
    http.post(predictCall, body: {
      "plant_image": img64,
    }).then((res) {
      print(res);
    }).catchError((err) {
      print(err);
    });
    //print(img64.substring(0, 100));
    print(img64);
    setState(() {
      _image = image;
      _enabled = false;
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
      
      //To Remove the Debug Tag
      debugShowCheckedModeBanner: false,

      home : new Scaffold(
        body: Center(
          //child: _image == null ? Text('No image selected.'): Image.file(_image),
          child: _image == null ? _imageLogo : Image.file(_image),
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