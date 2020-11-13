import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


runNowPopUp(BuildContext context){

  final FirebaseAuth _auth = FirebaseAuth.instance;

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Continue to Log Out'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure that you want to Log Out?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Log Out'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}