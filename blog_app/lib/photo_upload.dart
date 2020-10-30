import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload({Key key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final formKey = GlobalKey<FormState>();
  String myValue;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  bool saveForm() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
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
            //image == null ? Text("No photo uploaded yet.") : Image.file(image),  //Image.file(File(_imageFile.path)),
            _imageFile == null ? Text("No photo uploaded yet.") : photoPost(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Add Photo",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget photoPost() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.file(
                File(_imageFile.path),
                height: 330.0,
                width: 660.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Explanation",
                ),
                validator: (value) {
                  return value.isEmpty ? "Enter an explanation" : null;
                },
                onSaved: (newValue) {
                  myValue = newValue;
                  return myValue;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                onPressed: saveForm,
                elevation: 10.0,
                child: Text("ADD NEW POST"),
                textColor: Colors.white,
                color: Colors.pink,
              )
            ],
          )),
    );
  }
}
