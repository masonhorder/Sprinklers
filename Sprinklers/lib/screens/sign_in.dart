import 'package:Sprinklers/services/auth.dart';
import 'package:Sprinklers/shared/constants.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:flutter/services.dart';




class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));

    return loading ? Loading() : Scaffold(
    
  
      backgroundColor: backgroundColor,
      body: Theme(
        data: ThemeData(
          // primaryColor: sprinklerBlue,
          // accentColor: sprinklerBlue,
          // hintColor: sprinklerBlue
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                pageTitle(context, "New Schedule", false, true),
                SizedBox(height: 20.0),
                Image(image: AssetImage('images/sprinklerImage.png'), width: 90,),
                SizedBox(height: 35.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'password', ),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a valid password' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  padding: EdgeInsets.all(7),
                  color: sprinklerBlue,
                  child: Text(
                    'Login',
                    style: basicWhite,
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }
                ),
                SizedBox(height: 27.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Need an account, ", style: basicBlack,),
                    InkWell(
                      child: Text("Sign Up", style: basicBlue,),
                      onTap: () => widget.toggleView(),
                    ),
                    Text("!", style: basicBlack,)
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}

































