import 'dart:io';

import 'package:blog_app/home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PhotoUpload extends StatefulWidget {
  PhotoUpload({Key key}) : super(key: key);

  @override
  _PhotoUploadState createState() => _PhotoUploadState();
}

class _PhotoUploadState extends State<PhotoUpload> {
  final formKey = GlobalKey<FormState>();
  String myValue;
  String url;

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

  void submitPhoto() async {
    if (saveForm()) {
      final StorageReference photoRef =
          FirebaseStorage.instance.ref().child("photos");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = photoRef
          .child(timeKey.toIso8601String() + ".jpg")
          .putFile((File(_imageFile.path)));
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      goHomePage();
      saveToDatabase(url);
    }
  }

  void saveToDatabase(url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat("MMMM d,yyyy");
    var formatTime = new DateFormat("EEE, hh:mm aaa");

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference dbRef = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "explanation": myValue,
      "date": date,
      "time": time
    };
    dbRef.child("Posts").push().set(data);
  }

  void goHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
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
        backgroundColor: Colors.black,
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
                onPressed: submitPhoto,
                elevation: 10.0,
                child: Text("ADD NEW POST"),
                textColor: Colors.white,
                color: Colors.black,
              )
            ],
          )),
    );
  }
}
