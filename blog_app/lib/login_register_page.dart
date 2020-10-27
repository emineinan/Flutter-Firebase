import 'package:flutter/material.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({Key key}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

enum PageType { login, register }

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final formKey = GlobalKey<FormState>();
  PageType _pageType = PageType.login;
  String email = "";
  String password = "";

  void goRegisterPage() {
    formKey.currentState.reset();
    setState(() {
      _pageType = PageType.register;
    });
  }

  void goLoginPage() {
    formKey.currentState.reset();
    setState(() {
      _pageType = PageType.login;
    });
  }

  bool saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 50.0,
      ),
      createLogo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        validator: (value) {
          return value.isEmpty ? "Please enter your email!" : null;
        },
        onSaved: (newValue) {
          email = newValue;
          return email;
        },
        decoration: InputDecoration(
            labelText: "Email",
            hintText: "example@gmail.com",
            border: OutlineInputBorder()),
      ),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        validator: (value) {
          return value.isEmpty ? "Please enter your password!" : null;
        },
        onSaved: (newValue) {
          password = newValue;
          return password;
        },
        obscureText: true,
        decoration: InputDecoration(
            labelText: "Password",
            hintText: "******",
            border: OutlineInputBorder()),
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget createLogo() {
    return Flexible(
      child: Image.asset("images/blog_logo.png"),
    );
  }

  List<Widget> createButtons() {
    if (_pageType == PageType.login) {
      return [
        RaisedButton(
            padding: EdgeInsets.all(8.0),
            onPressed: saveForm,
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 20.0),
            ),
            textColor: Colors.white,
            color: Colors.pink),
        FlatButton(
          onPressed: goRegisterPage,
          child: Text(
            "Register",
            style: TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.black,
        )
      ];
    } else {
      return [
        RaisedButton(
            padding: EdgeInsets.all(8.0),
            onPressed: saveForm,
            child: Text(
              "REGISTER",
              style: TextStyle(fontSize: 20.0),
            ),
            textColor: Colors.white,
            color: Colors.pink),
        FlatButton(
          onPressed: goLoginPage,
          child: Text(
            "Login",
            style: TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.black,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }
}
