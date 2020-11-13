import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


runNowPopUp(BuildContext context){
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Run Now'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Run Now Form'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {
              // await _auth.signOut();
              // Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Run'),
            onPressed: () async {
              // await _auth.signOut();
              // Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          
        ],
      );
    },
  );
}