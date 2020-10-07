import 'dart:convert';

import 'package:breaking_bad_app/model/character.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  List<Character> characterList = new List<Character>();

  void getCharacters() async {
    Response result = await get("https://breakingbadapi.com/api/characters");
    var data = await jsonDecode(result.body);
    setState(() {
      for (var i = 0; i < data.length; i++) {
        Character c = Character();
        c.id = data[i]["id"];
        c.name = data[i]["name"];
        c.img = data[i]["img"];
        c.nickname = data[i]["nickname"];

        characterList.add(c);
      }
    });
  }

  @override
  void initState() {
    getCharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Characters"),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: characterList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(characterList[index].name),
                  subtitle: Text(characterList[index].nickname),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(characterList[index].img),
                  ),
                );
              }),
        ));
  }
}
