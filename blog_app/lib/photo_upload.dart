import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload({Key key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Upload Photo"),
      ),
      body: Center(
        child:
            //image == null ? Text("No photo uploaded yet.") : Image.file(image),
            _imageFile == null
                ? Text("No photo uploaded yet.")
                : Image.file(File(_imageFile.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Photo",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
