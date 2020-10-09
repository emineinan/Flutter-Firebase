import 'dart:convert';

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
              title: Text(character.name),
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
