// import 'package:Sprinklers/models/user.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:Sprinklers/elements/signOutPopUp.dart';
import 'package:Sprinklers/screens/settings/account.dart';
import 'package:Sprinklers/screens/settings/devices.dart';





// import 'package:Coding/functions/functions.dart';
// import 'package:Coding/style/headers.dart';
// import 'package:provider/provider.dart';
// import 'package:Coding/screens/home_page_panels.dart';
// import 'package:Coding/style/global.dart';
// import 'package:date_format/date_format.dart';
// import 'package:Coding/models/models.dart';






class SettingsPage extends StatefulWidget {
  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<SettingsPage> {
  
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 40.0),
            Container(
              child: pageTitle(context, "Settings", false, true, setState),
            ),
            SizedBox(height: 40.0),
            Container(
              child:Column(
                children: [

                  // device stuff
                  // Column(
                  //   children: [


                      // devices
                      InkWell(
                        onTap: () async{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DevicesSettings()),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: lightGrey, width: 1,),
                              bottom: BorderSide(color: lightGrey, width: 1,),

                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width:50),
                              Text("Devices", style: basicBlack,),
                              Container(
                                width:50,
                                child: Icon(Icons.keyboard_arrow_right), 
                              )
                            ]
                          )
                        )
                      ),


                      SizedBox(height:1),



                      // schedule a pause
                      InkWell(
                        // onTap: () async{
                        //   await _auth.signOut();
                        //   Navigator.pop(context);
                        // },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: lightGrey, width: 1,),
                              bottom: BorderSide(color: lightGrey, width: 1,),

                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child:Center(
                            child: Text("Schedule a Pause", style: basicBlack,),
                          )
                        )
                      ),


                  //   ],
                  // ),

                  SizedBox(height:1),




                  // acoount
                  // Column(
                  //   children: [

                      // account info
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AccountInfoSettings()),
                          );
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: lightGrey, width: 1,),
                              bottom: BorderSide(color: lightGrey, width: 1,),

                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width:50),
                              Text("Account Info", style: basicBlack,),
                              Container(
                                width:50,
                                child: Icon(Icons.keyboard_arrow_right), 
                              )
                            ]
                          )
                        )
                      ),

                      SizedBox(height:100),

                      // logout
                      InkWell(
                        onTap: () async{
                          // await _auth.signOut();
                          // Navigator.pop(context);
                          runNowPopUp(context);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: lightGrey, width: 1,),
                              bottom: BorderSide(color: lightGrey, width: 1,),

                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child:Center(
                            child: Text("Log Out", style: basicRed,)
                          )
                        )
                      ),
                  //   ],
                  // )


                ],
              )
            ),
          ],
        )
      ),
    );
  }
}



