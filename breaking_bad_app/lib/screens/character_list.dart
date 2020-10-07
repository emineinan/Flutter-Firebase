import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class CharacterList extends StatefulWidget {
  CharacterList({Key key}) : super(key: key);

  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  void getCharacters() async {
    Response result = await get("https://breakingbadapi.com/api/characters");
    var data = await jsonDecode(result.body);
    print(data[0]["name"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getCharacters();
          },
          child: Text("Get Characters"),
        ),
      ),
    );
  }
}
