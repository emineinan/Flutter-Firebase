import 'package:blog_app/authentication.dart';
import 'package:blog_app/home_page.dart';
import 'package:blog_app/login_register_page.dart';
import 'package:flutter/material.dart';

class MappingPage extends StatefulWidget {
  final AuthOperation auth;
  MappingPage({Key key, this.auth}) : super(key: key);

  @override
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus { signIn, notSignIn }

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignIn;

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId) {
      setState(() {
        if (firebaseUserId == null) {
          authStatus = AuthStatus.notSignIn;
        } else {
          authStatus = AuthStatus.signIn;
        }
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignIn:
        return LoginRegisterPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
        break;
      case AuthStatus.signIn:
        return HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
        break;
      default:
        return null;
    }
  }
}
