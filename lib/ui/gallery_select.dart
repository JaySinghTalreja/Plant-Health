import 'dart:io';
import 'package:flutter/material.dart';

//Additional Imports
import 'package:image_picker/image_picker.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; //For Circular Loading Animation

class GallerySelect extends StatefulWidget {
  @override
  _GallerySelectState createState() => _GallerySelectState();
}

class _GallerySelectState extends State<GallerySelect> {
  //Image Variable
  File _image;
  
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
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
        ) : Image.file(_image) //Replacing Button with Image
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