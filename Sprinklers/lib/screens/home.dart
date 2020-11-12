import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


// import 'package:Coding/functions/functions.dart';
// import 'package:Coding/style/headers.dart';
// import 'package:provider/provider.dart';
// import 'package:Coding/screens/home_page_panels.dart';
// import 'package:Coding/style/global.dart';
// import 'package:date_format/date_format.dart';
// import 'package:Coding/models/models.dart';






class HomePage extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<HomePage> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Container(
              child: pageTitle(context, "Sprinklers", true, false),
            ),
            // FlatButton.icon(
            //   icon: Icon(Icons.person),
            //   label: Text('logout'),
            //   onPressed: () async {
            //     await _auth.signOut();
            //   },
            // ),
          ],
        )
      ),
    );
  }
}



