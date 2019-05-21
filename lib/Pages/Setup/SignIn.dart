import 'package:nyeremenyjatek/Pages/setup/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nyeremenyjatek/Pages/home.dart';
import 'package:nyeremenyjatek/login_example_icons.dart';
import 'package:nyeremenyjatek/Pages/MainMenu.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  Future<FirebaseUser> _loginWithFacebook() async {
    var facebookLogin = new FacebookLogin();
    var result = await facebookLogin.logInWithReadPermissions(['email']);
    debugPrint(result.status.toString());

    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: accessToken.token);

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage("assets/loginPage/backr_384x640.svg"),
        fit: BoxFit.cover),
      ),
          ),
          Center(
              child: isLoggedIn
                  ? Column(
                children: <Widget>[
                  Text('Name: ' + currentUser.displayName),
                  Image.network(currentUser.photoUrl)
                ], //children: <Widget>[]
              ) //Column
                  : FlatButton(child: new ButtonBar(alignment: MainAxisAlignment.center,
              children: [new Text('FACEBOOKKAL CSATLAKOZOM'), new Icon(LoginExample.google_b_hit)]),
                onPressed: signInWithFacebook,
              )
          ), //Center
          FlatButton(
          child:Text('MainMenu //Debug'),
    onPressed: navigateToMainMenu,
    ),
          FlatButton(child: new ButtonBar(alignment: MainAxisAlignment.center,
    children: [
      new Text('GOOGLE-EL CSATLAKOZOM'),
      new Icon(LoginExample.google_a)]),
            onPressed: signInWithGmail,
          ), //FlatButton
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide an email';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (input) => _email = input,
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Longer password please';
                      } //if
                    }, //validator
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ), //TextFormField
                ], // <Widget>[]
              )), //Form
          Column(
            children: <Widget>[
              RaisedButton(onPressed: signIn,
              child: Text('Sign in')),
              FlatButton(onPressed: navigateToSignUp,
                  child: Text('Doesn''t have an account? Sign up!'))
            ], //children: <Widget>[]
          ), //Column
        ], //children: <Widget>[]
      ), //Column
    ); //Scaffold
  } //Widget build

  void navigateToMainMenu(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainMenuPage(), fullscreenDialog: true));
  }

  void signInWithFacebook() {
    _loginWithFacebook().then((response) {
      if (response != null) {
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }

  void signInWithGmail() {
    _loginWithGoogle().then((response) {
      if (response != null) {
        currentUser = response;
        isLoggedIn = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: response)));
      }
    });
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }

  void signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      } // catch
    } //if
  } // signIn()


}
