import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

void main() {
  runApp(MaterialApp(
    home: MyMainPage(),
  ));
}

class MyMainPage extends StatefulWidget {
  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Facebook Login Example"),),
      body: Center(
        child: isLoggedIn ? null : FacebookSignInButton(onPressed: (){},
        ),
      ),
    );
  }
}
