import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nyeremenyjatek/Pages/Setup/SignIn.dart';
import 'package:nyeremenyjatek/Pages/MainMenu.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password, _phoneNumber, _name;
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
    return new Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child:Text('MainMenu'),
            onPressed: navigateToMainMenu,
          ),
          MaterialButton(
              child: FacebookSignInButton(
            onPressed: _loginWithFacebook,
          )), //MaterialButton - Facebook
          MaterialButton(
              child: GoogleSignInButton(
            onPressed: _loginWithGoogle,
          )), //MaterialButton - Google
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide a name';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Name'),
                    onSaved: (input) => _name = input,
                  ), //TextFormField - Name
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Provide an email';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Email'),
                    onSaved: (input) => _email = input,
                  ), //TextFormField - Email
                  TextFormField(
                    validator: (input){
                      if(input.isEmpty){
                        return 'Provide a phone number';
                      }
                    },
                    decoration: InputDecoration(labelText: 'PhoneNumber'),
                    onSaved: (input) => _phoneNumber = input,
                  ), //TextFormField - Phone number
                  TextFormField(
                    validator: (input) {
                      if (input.length < 6) {
                        return 'Longer password please';
                      }
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    onSaved: (input) => _password = input,
                    obscureText: true,
                  ), //TextFormField - Password
                  RaisedButton(
                    onPressed: signUp,
                    child: Text('Sign up'),
                  ),
                  FlatButton(onPressed: navigateToSignIn,
                      child: Text('Already have an account, Log in'))
                ],
              )), //Body: Form
        ],
      ), //Body: Column
    );
  } // Widget build

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignIn(), fullscreenDialog: true));
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

  void navigateToMainMenu(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MainMenuPage(), fullscreenDialog: true));
  }

  void signInWithGmail() {
    _loginWithGoogle().then((response) {
      if (response != null) {
        currentUser = response;
        isLoggedIn = true;
        setState(() {});
      }
    });
  }
}
