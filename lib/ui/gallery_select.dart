import 'dart:io' as Io;
import 'dart:convert';
import 'package:flutter/material.dart';

//Additional Imports
import 'package:image_picker/image_picker.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; //For Circular Loading Animation

//Imports for REST API 
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

//Result Screen Import
import 'package:plant_health/ui/result.dart';


class GallerySelect extends StatefulWidget {
  @override
  _GallerySelectState createState() => _GallerySelectState();
}

class _GallerySelectState extends State<GallerySelect> {
  //Image Variable
  Io.File _image = null;
  String _result = null;
  //final String predictCall = "http://127.0.0.1:8000/API/predict";

  Future getImage() async {
    setState(() {
      _image = null;
      _result = null;
    });

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    final bytes = image.readAsBytesSync();
    //print(img64.substring(0, 100));
    String img64 = "data:image/jpeg;base64," + base64Encode(bytes);
    setState(() {
      _image = image;
    });
    //final http.Response response = await http.get('http://192.168.43.185:8000/API/');
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
    //print(_result);
    //print(img64.substring(0, 100));
    //print(img64);
    //await new Future.delayed(const Duration(seconds : 2));
    setState(() {    
      _result = varResult;
      //_image = null;
      _image = image;
    });
  }

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
    setState(() {
      _image = null;
      _result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        //--------------------------------------------------------Issues Commented-------------------------
        //child: _image == null ? Text('No image selected.'): Image.file(_image),
        //Removed the Image Switch with button so that we can process the Image just after selecting it from gallery without displying in on the child widget
        //child: _image == null ? argonButton : Image.file(_image),

        //Using the ArgonButton to pick the image and replacing the button with image after statechange

        child: _image == null ? ArgonButton(
          height: 50,
          width: 200,
          borderRadius: 5.0,
          color: Colors.lightGreen,
          child: Text(
            "Select From Gallery",
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
              getImage();
              stopLoading();
              //setImage(image);
            }
            //tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
          },
        ) : (_result == null ? Image.asset('assets/ApiSpinLoad.gif',width: 100,height: 200,) : 
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
        ) 
      ),

      //A Floating Action Button Removed ! Alternative : Used An Argon Button
      /*floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),*/
    );
  }
}