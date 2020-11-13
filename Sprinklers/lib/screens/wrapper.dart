import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/screens/authenticate.dart';
import 'package:Sprinklers/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserID>(context);
    // print("user");
    // print(user.uid);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return HomePage();
    }
    
  }
}