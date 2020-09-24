import 'package:coffee_shop/models/user.dart';
import 'package:coffee_shop/screens/authenticate/authenticate.dart';
import 'package:coffee_shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    //return either Home or Authenticate widget
    return Authenticate();
  }
}
