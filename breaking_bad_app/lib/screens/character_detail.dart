import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad_app/functions/card.dart';
import 'package:breaking_bad_app/model/character.dart';
import 'package:breaking_bad_app/screens/add_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:image_fade/image_fade.dart';

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
    Response response;
    if (widget.id == -1) {
      response = await get('https://breakingbadapi.com/api/character/random');
    } else {
      response =
          await get('https://breakingbadapi.com/api/characters/${widget.id}');
    }
    var data = await jsonDecode(response.body); //map

    setState(() {
      character.name = data[0]["name"] == null ? "Unknown" : data[0]["name"];
      character.img = data[0]["img"] == null ? "Unknown" : data[0]["img"];
      character.id = data[0]["char_id"];
      character.nickname =
          data[0]["nickname"] == null ? "Unknown" : data[0]["nickname"];
      character.status =
          data[0]["status"] == null ? "Unknown" : data[0]["status"];
      character.birthday =
          data[0]["birthday"] == null ? "Unknown" : data[0]["birthday"];
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
            backgroundColor: Colors.grey[400],
            appBar: AppBar(
              title: TypewriterAnimatedTextKit(
                text: ["${character.name}"],
                textStyle: TextStyle(fontSize: 25.0),
                repeatForever: true,
                speed: Duration(milliseconds: 400),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ImageFade(
                    image: NetworkImage(character.img),
                    height: 300,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    fadeDuration: Duration(seconds: 3),
                    fadeCurve: Curves.easeInCubic,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                  width: 250.0,
                  child: Divider(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                buildCard("Name:", character.name),
                buildCard("Nickname:", character.nickname),
                buildCard("Birthday:", character.birthday),
                buildCard("Status:", character.status),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddComments(
                              character: character,
                            )));
              },
              child: Icon(Icons.comment),
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
