import 'package:flutter/material.dart';
import 'package:Sprinklers/style/style.dart';

pageTitle(String pageHeaderTitle, bool homePage){
  return Container(margin: EdgeInsets.only(top: 60, bottom: 25), child: Text(pageHeaderTitle, style: pageTitleStyle),);
  // return FlatButton.icon(
  //   icon: Icon(Icons.person),
  //   label: Text('logout'),
  //   onPressed: () async {
  //     await _auth.signOut();
  //   },
  // ),
}