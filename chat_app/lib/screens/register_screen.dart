import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "registerScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  String email;
  String password;

  AnimationController controller;
  Animation animationBorder;
  Animation animationColor;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 5), value: 0.2);

    animationBorder = BorderRadiusTween(
            begin: BorderRadius.circular(0.0), end: BorderRadius.circular(32.0))
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  child: Image.asset("images/logo2.png"),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xFF574b90)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: animationBorder.value,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFF574b90),
                      ),
                      borderRadius: animationBorder.value,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xFF574b90)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: animationBorder.value,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color(0xFF574b90),
                      ),
                      borderRadius: animationBorder.value,
                    )),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Color(0xFF574b90),
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      onPressed: () async {
                        try {
                          final newUser =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (newUser != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                        } catch (e) {
                          print(e.message);
                        }
                      },
                      minWidth: 170.0,
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
