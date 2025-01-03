import 'package:Sprinklers/screens/settings/editAccount.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:Sprinklers/services/auth.dart';









class AccountInfoSettings extends StatefulWidget {
  @override
  _AccountInfoSettingsState createState() => _AccountInfoSettingsState();
}

class _AccountInfoSettingsState extends State<AccountInfoSettings> {
  
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  

  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    return Scaffold(
      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40.0),
                    Container(
                      child: pageTitle(context, "Account", false, true, setState),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Name: " + userData.firstName + " " + userData.lastName, style: basicBlack,),
                        ],
                      )
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Email: " + userData.email, style: basicBlack,),
                        ],
                      )
                    )

                  ]
                ),
              )
            );
          }return Loading();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditAccountInfoSettings()),
          );
        },
        child: Icon(Icons.edit),
        backgroundColor: sprinklerBlue,
      ),
    );      
  }
}



