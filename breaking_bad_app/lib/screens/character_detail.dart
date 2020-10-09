import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/model/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class CharacterDetail extends StatefulWidget {
  final int id;
  CharacterDetail({this.id});

  @override
  _CharacterDetailState createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  Character character = new Character();
  bool isLoad = false;

  void getCharacterwithId() async {
    Response response =
        await get("https://breakingbadapi.com/api/characters/${widget.id}");
    var data = await jsonDecode(response.body); //map

    setState(() {
      character.name = data[0]["name"];
      isLoad = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCharacterwithId();
  }

  @override
  Widget build(BuildContext context) {
    return isLoad
        ? Scaffold(
            appBar: AppBar(
              title: TypewriterAnimatedTextKit(
                text: ["${character.name}"],
                textStyle: TextStyle(fontSize: 25.0),
                repeatForever: true,
                speed: Duration(milliseconds: 400),
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: SpinKitThreeBounce(
                color: Colors.redAccent,
                size: 70.0,
              ),
            ),
          );
  }
}
