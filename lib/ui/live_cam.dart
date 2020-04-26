import 'dart:ffi';
import 'dart:io' as Io;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//Additional Imports
//import 'package:progress_button/progress_button.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; //For Circular Loading Animation

//Imports for REST API 
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

//Result Screen Import
import 'package:plant_health/ui/result.dart';

class LiveCam extends StatefulWidget {
  @override
  _LiveCamState createState() => _LiveCamState();
}

class _LiveCamState extends State<LiveCam> {

  //Image
  Io.File _image;
  String _result;

  //API 
  //final String predictCall = 'http://192.168.43.185:8000/API/predict';

  
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

  //Start New Activity
  showDisease() async {
    await Navigator.push(
      context, 
      PageRouteBuilder(
        transitionDuration: Duration(seconds:2),
        transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation,
          Widget child) {
            animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
            return ScaleTransition(
              alignment: Alignment.center,
              scale: animation,
              child: child,
            ); 
        },
        pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secAnimation) {
            return ResultScreen(dataDisease: _result,);
          }
      )
    );
    /*setState(() {
      _image = null;
      _result = null;
    });*/
  }

  //Function to Select Image and convert it into base64 format
  Future getImage() async {
    setState((){
      _image = null;
      _result = null;
    });
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    //Trial to Convert Image to Base64
    final bytes = image.readAsBytesSync();
    String img64 = "data:image/jpeg;base64," + base64Encode(bytes);
    setState(() {
      _image = image;
    });
    final http.Response response = await http.post(
      'http://192.168.43.185:8000/API/predict', 
      body: {
        "plant_image": img64,
      }
    );
    var predictionData = json.decode(response.body);
    print(predictionData);
    String res = predictionData['data'];
    String varResult;
    if(res.contains("mosaic_virus", 7)) {
      varResult = "Mosaic Virus";
      print("Mosaic Virus");
    }
    else if(res.contains("Late_blight", 7)) {
      varResult = "Late Blight";
      print("Late Blight");
    }
    else if(res.contains("Spider_mites", 7)) {
      varResult = "Yellow Leaf Spider Mites";
      print("Spider Mites");
    }
    else if(res.contains("Septoria_leaf_spot", 7)) {
      varResult = "Septoria Leaf Spot";
      print("Septoria Leaf Spot");
    }
    else if(res.contains("Curl_Virus",7)){
      varResult = "Curl Virus";
      print("Curl Virus");
    }
    else if(res.contains("Bacterial_spot",7)) {
      varResult = "Bacterial Spot";
      print("Bacterial Spot");
    }
    else if(res.contains("Target_Spot", 7)) {
      varResult = "Target Spot";
      print( "Target Spot");
    }
    else if(res.contains("Leaf_Mold", 7)) {
      varResult = "Leaf Mold";
      print("Leaf Mold");
    }
    else if(res.contains("Early_blight", 7)) {
      varResult = "Early Blight";
      print("Early Blight");
    }
    else {
      varResult = "Healthy";
      print("Healthy");
    }
    setState(() {    
      _result = varResult;
      //_image = null;
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
      
      //To Remove the Debug Tag
      debugShowCheckedModeBanner: false,

      home : new Scaffold(
        body: Center(
          //child: _image == null ? Text('No image selected.'): Image.file(_image),
          child: _image == null ? _imageLogo : (_result == null ? Image.asset('assets/ApiSpinLoad.gif',width: 100,height: 200,) : 
              ArgonButton(
              height: 50,
              width: 200,
              borderRadius: 5.0,
              color: Colors.lightGreen,
              child: Text(
                "Show",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ),
              ),
              loader: Container(
                padding: EdgeInsets.all(10),
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                  // size: loaderWidth ,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                if(btnState == ButtonState.Idle){
                  startLoading();
                  //Delaying for the loading circle animation
                  await new Future.delayed(const Duration(seconds : 2));
                  
                  //Start New Activity
                  showDisease();
                  stopLoading();
                  //setImage(image);
                }
                //tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
              },
            )
          ),
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