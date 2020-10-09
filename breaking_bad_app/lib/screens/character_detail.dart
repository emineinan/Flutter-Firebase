import 'package:flutter/material.dart';

class CharacterDetail extends StatefulWidget {
  final int id;
  CharacterDetail({this.id});

  @override
  _CharacterDetailState createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  void getCharacterwithId() async {
    print("id: ");
    print(widget.id);
  }

  @override
  void initState() {
    super.initState();
    getCharacterwithId();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
