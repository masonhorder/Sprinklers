import 'package:flutter/material.dart';
import 'package:Sprinklers/style/style.dart';

pageTitle(String pageHeaderTitle, bool homePage){
  return Container(child: Text(pageHeaderTitle, style: pageTitleStyle),);
  // return FlatButton.icon(
  //   icon: Icon(Icons.person),
  //   label: Text('logout'),
  //   onPressed: () async {
  //     await _auth.signOut();
  //   },
  // ),
}