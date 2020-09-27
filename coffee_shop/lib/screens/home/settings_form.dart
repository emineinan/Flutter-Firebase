import 'package:coffee_shop/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Update your brew settings.",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Name:"),
            validator: (value) => value.isEmpty ? "Please enter a name" : null,
            onChanged: (value) => setState(() => _currentName = value),
          ),
          SizedBox(height: 20.0),
          //dropdown

          DropdownButtonFormField(
            decoration: textInputDecoration,
            value: _currentSugars ?? "0",
            items: sugars.map((sugar) {
              return DropdownMenuItem(
                value: sugar,
                child: Text("$sugar sugars"),
              );
            }).toList(),
            onChanged: (value) => setState(() => _currentSugars = value),
          ),
          //slider
          Slider(
              value: (_currentStrength ?? 100).toDouble(),
              activeColor: Colors.brown[_currentStrength ?? 100],
              inactiveColor: Colors.brown[_currentStrength ?? 100],
              min: 100.0,
              max: 900.0,
              divisions: 8,
              onChanged: (value) =>
                  setState(() => _currentStrength = value.round())),
          RaisedButton(
              color: Colors.deepOrangeAccent,
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(_currentName);
                print(_currentSugars);
                print(_currentStrength);
              }),
        ],
      ),
    );
  }
}
