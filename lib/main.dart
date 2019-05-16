import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  bool isLoading = false;
  FirebaseUser currentUser;

  //Google Login
  Future<FirebaseUser> _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.accessToken,
        accessToken: googleAuth.accessToken,
    );
    FirebaseUser firebaseUser = await _auth.signInWithCredential(credential);
    return firebaseUser;
  }

  //Facebook Login
  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);
    debugPrint(result.status.toString());

    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);

    if (result.status == FacebookLoginStatus.loggedIn) {
      FirebaseUser user = await _auth.signInWithCredential(credential);
      return user;
    }
    return null;
  }

  void _logInGM(){
    _loginWithGoogle().then((response){
      if(response != null){
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }

  void _logInFB(){
    _loginWithFacebook().then((response){
      if(response != null){
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }

  void _logOut() async {
    await _auth.signOut().then((response){
      isLoggedIn = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLoggedIn ? "Profile Page": "Nyeremeny Jatek"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: _logOut,
        ),
      ],
      ),


      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: FacebookSignInButton(
              onPressed: _logInFB,
            )
          ),
          Expanded(
              child: GoogleSignInButton(
                onPressed: _logInGM,
              )
          ),
        ],
      )

      /*body: Container(
        child: Center(
        child: isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Text('Name: ' + currentUser.displayName),
            Image.network(currentUser.photoUrl),
        ],

        )
            : FacebookSignInButton(
                onPressed: _logInFB,
        )

        ),

      )*/
    );
  }
}
