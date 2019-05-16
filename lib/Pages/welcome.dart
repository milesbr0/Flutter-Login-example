import 'package:nyeremenyjatek/Pages/setup/signInWithMail.dart';
import 'package:nyeremenyjatek/Pages/setup/signUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

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

  Future<FirebaseUser> _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nyeremenyjatek Demo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: navigateToSignIn,
            child: Text('Sign in'),
          ),
          RaisedButton(
            onPressed: navigateToSignUp,
            child: Text('Sign up'),
          ),
          MaterialButton(
            child:FacebookSignInButton(
              onPressed: _loginWithFacebook,
            )
          ),
          MaterialButton(
            child: GoogleSignInButton(
              onPressed: _loginWithGoogle,
            )
          )
        ],
      ),
    );
  }

  void signInWithFacebook(){
    _loginWithFacebook().then((response){
      if(response != null){
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }

  void signInWithGmail(){
    _loginWithGoogle().then((response){
      if(response != null){
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage(), fullscreenDialog: true));
  }

}