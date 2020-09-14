import 'package:flutter/material.dart';
import 'package:major2/FadeAnimation.dart';
import 'package:major2/auth.dart';
import 'package:major2/option.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  static final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  
  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);
        setState(() {
          _authHint = 'Signed In\n\nUser id: $userId';
        });
        widget.onSignIn();
      }
      catch (e) {
        setState(() {
          Toast.show("${e.toString()}", context,gravity:  Toast.CENTER);
          _authHint = 'Wrong Email or Password';
          // _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

final pageTitle = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image(
          image: AssetImage('assets/logo.png'),
          height: 60,
        ),
        Text(
          "Log In.",
          style: TextStyle(
            fontFamily: 'Quicksand',  
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 45.0,
          ),
        ),
        Text(
          "Welcome!",
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );


final tellaboutu = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Tell us about",
          style: TextStyle(
            fontFamily: 'Quicksand',  
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 45.0,
          ),
        ),
        Text(
          "you.",
          style: TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );


  List<Widget> usernameAndPassword() {
    switch(_formType){
      case FormType.login:
      return [
        pageTitle,
      padded(child: new TextFormField(
        key: new Key('email'),
        // decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
         decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand'),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        validator: (val) => !val.contains('.com') ? 'Incorrect Email Format.' : null,
        onSaved: (val) => _email = val.trim(),
      )),
      
      padded(child: new TextFormField(
        key: new Key('password'),
        // decoration: new InputDecoration(labelText: 'Password'),
         decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.white,fontFamily: 'Quicksand'),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
        obscureText: true,
        autocorrect: false,
        style: TextStyle(color: Colors.white),
        validator: (val) => val.length<6 ? 'Password too short.' : null,
        onSaved: (val) => _password = val,
      ))
      ];

     
    case FormType.register:
        return [
          tellaboutu,
          padded(child: new TextFormField(
        // key: new Key('email'),
        // decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
         decoration: InputDecoration(
        labelText: 'Name',
        labelStyle: TextStyle(color: Colors.black,fontFamily: 'Quicksand'),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        // validator: (val) => !val.contains('.com') ? 'Incorrect Email Format.' : null,
        // onSaved: (val) => _email = val.trim(),
      )),
      padded(child: new TextFormField(
        key: new Key('email'),
        // decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
         decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(color: Colors.black,fontFamily: 'Quicksand'),
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        validator: (val) => !val.contains('.com') ? 'Incorrect Email Format.' : null,
        onSaved: (val) => _email = val.trim(),
      )),
      
      padded(child: new TextFormField(
        key: new Key('password'),
        // decoration: new InputDecoration(labelText: 'Password'),
         decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.black,fontFamily: 'Quicksand'),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.length<6 ? 'Password too short.' : null,
        onSaved: (val) => _password = val,
      ))
        ];
    }
    return null;
  }

  List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [
          PrimaryButton(
            key: new Key('login'),
            text: 'SIGN IN',
            height: 44.0,
            color: Colors.white,
            onPressed: validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-account'),
            child: new Text("New User? Create Account",style: TextStyle(color: Colors.white70,fontSize: 18,fontWeight: FontWeight.w600),),
            onPressed: moveToRegister
          ),
        ];
      case FormType.register:
        return [
          new PrimaryButton(
            key: new Key('register'),
            text: 'Create account',
            height: 44.0,
            color: const Color(0xFFfbab66),
            onPressed: validateAndSubmit
          ),
          new FlatButton(
            key: new Key('need-login'),
            child: new Text("Have an account? Login"),
            onPressed: moveToLogin
          ),
        ];
    }
    return null;
  }

  Widget hintText() {
    return new Container(
        //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center)
    );
  }


  @override
  Widget build(BuildContext context) {
    const primaryColor = const Color(0xFFfbab66);
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text("Nagrik Sewa"),
        backgroundColor: _formType == FormType.login?primaryColor:Colors.white,
        elevation: 0,
      ),
      backgroundColor: _formType == FormType.login?primaryColor:Colors.white,
      body: new SingleChildScrollView(child: new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(16.0),
        child: new Column(
          children: [
            new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new Form(
                      key: formKey,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: 
                        usernameAndPassword() + submitWidgets(),
                        
                      )
                  )
              ),
            ]),
            hintText()
          ]
        )
      ))
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}







class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.key, this.text, this.height, this.onPressed,this.color}) : super(key: key);
  final Key key;
  final String text;
  final double height;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        color: color,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
        ),
      ),
    );
    // return new ConstrainedBox(
    //   constraints: BoxConstraints.expand(height: height),
    //   child: new RaisedButton(
    //       child: new Text(text, style: new TextStyle(color: Colors.white, fontSize: 20.0)),
    //       shape: new RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(height / 2))),
    //       color: Colors.blue,
    //       textColor: Colors.black87,
    //       onPressed: onPressed),
    // );
  }
}