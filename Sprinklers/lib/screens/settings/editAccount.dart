import 'package:Sprinklers/models/editForm.dart';
import 'package:Sprinklers/services/auth.dart';
import 'package:Sprinklers/shared/constants.dart';
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









class EditAccountInfoSettings extends StatefulWidget {
  @override
  _EditAccountInfoSettingsState createState() => _EditAccountInfoSettingsState();
}

class _EditAccountInfoSettingsState extends State<EditAccountInfoSettings> {
  
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  String initialEmail = '';
  String initialFirstName = '';
  String initialLastName = '';

  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    return Scaffold(
      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            initialEmail = userData.email;
            initialFirstName = userData.firstName;
            initialLastName = userData.lastName;

            return Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40.0),
                    Container(
                      child: pageTitle(context, "Edit Account", false, false, setState),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:30),
                      child: Column(
                        children:[
                          SizedBox(height: 35.0),
                          TextFormField(
                            initialValue: userData.email,
                            decoration: textInputDecoration.copyWith(hintText: 'email'),
                            validator: (val) => val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => EditForm.email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ((MediaQuery.of(context).size.width)/2)-35,
                                child: TextFormField(
                                  initialValue: userData.firstName,
                                  decoration: textInputDecoration.copyWith(hintText: 'first name'),
                                  validator: (val) => val.length < 1 ? 'Enter a first name' : null,
                                  onChanged: (val) {
                                    setState(() => EditForm.firstName = val);
                                  },
                                ),
                              ),
                              Container(
                                width: ((MediaQuery.of(context).size.width)/2)-35,
                                child: TextFormField(
                                  initialValue: userData.lastName,
                                  decoration: textInputDecoration.copyWith(hintText: 'last name'),
                                  validator: (val) => val.length < 1 ? 'Enter a last name' : null,
                                  onChanged: (val) {
                                    setState(() => EditForm.lastName = val);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 200,
                      child: RaisedButton(
                        padding: EdgeInsets.all(11),
                        color: sprinklerBlue,
                        child: Text(
                          'Reset Password',
                          style: basicWhite,
                        ),
                        onPressed: () async {
                          
                        }
                      )
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: 200,
                      child: RaisedButton(
                        padding: EdgeInsets.all(11),
                        color: Colors.red,
                        child: Text(
                          'Delete Account',
                          style: basicWhite,
                        ),
                        onPressed: () async {
                          String returned = await AuthService().deleteAcount(context);
                        }
                      )
                    ),

                  ]
                ),
              )
            );
          }return Loading();
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DatabaseService(uid: user.uid).updateUserData(EditForm.firstName == null ? initialFirstName : EditForm.firstName, EditForm.lastName == null ? initialLastName : EditForm.lastName, EditForm.email == null ? initialEmail : EditForm.email);
          Navigator.pop(context,);
        },
        child: Icon(Icons.save_rounded),
        backgroundColor: sprinklerBlue,
      ),
    );      
  }
}



