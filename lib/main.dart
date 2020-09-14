import 'package:flutter/material.dart';
import 'package:major2/login_page.dart';
import 'package:major2/option.dart';
import 'package:major2/auth.dart';
import 'package:major2/MyModel.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(auth: new Auth()),
      ),
    );

class MyApp extends StatefulWidget {
  MyApp({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;
  @override
  _MyAppState createState() => _MyAppState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}


class _MyAppState extends State<MyApp> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
 
  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
        if(authStatus == AuthStatus.signedIn){
          appData.uid = userId;
        }
      });
    });
  }

    void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
      appData.uid = widget.auth.currentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
       switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        return new OptionPage(
          // auth: widget.auth,
          // onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn)
        );
    }
  }
}