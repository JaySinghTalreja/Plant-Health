import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GallerySelect extends StatefulWidget {
  @override
  _GallerySelectState createState() => _GallerySelectState();
}

class _GallerySelectState extends State<GallerySelect> {
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
        child: _image == null ? Text('No image selected.'): Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}