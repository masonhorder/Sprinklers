import 'package:Sprinklers/services/auth.dart';
import 'package:Sprinklers/shared/constants.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:flutter/services.dart';




class ScheduleForm extends StatefulWidget {

  final Function toggleView;
  ScheduleForm({ this.toggleView });

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  List checked = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));

    return Scaffold(
    
  
      backgroundColor: backgroundColor,
      body: Theme(
        data: ThemeData(
          // primaryColor: sprinklerBlue,
          // accentColor: sprinklerBlue,
          // hintColor: sprinklerBlue
        ),
        child: Container(
          // width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Container(
                // width: MediaQuery.of(context).size.width,
                child: Column(
                
                  children: [
                    
                    SizedBox(height: 40.0),
                    

                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: pageTitle(context, "Schedule", false, true),
                    ),

                    SizedBox(height: 20.0),
                    // Image(image: AssetImage('images/sprinklerImage.png'), width: 90,),
                    SizedBox(height: 35.0),
                    SingleChildScrollView(
                      child: Column(
                        children:[

                          Container(
                            padding: EdgeInsets.only(left:50, right: 50, bottom: 8),
                            alignment: Alignment.centerLeft,
                            child: Text("Name:", style: TextStyle(fontSize:16)),
                          ),
                          Container(
                            padding: EdgeInsets.only(left:50, right: 50),
                            child: TextFormField(
                              decoration: textInputDecoration.copyWith(hintText: 'schedule name'),
                              validator: (val) => val.isEmpty ? 'schedule name' : null,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left:50, right: 50, bottom: 8, top:40),
                            alignment: Alignment.centerLeft,
                            child: Text("Start Time:", style: TextStyle(fontSize:16)),
                          ),
                          Row(
                            children: [
                              // Text("hi"),
                              SizedBox(width:50),
                              Container(
                                width:58,
                                // height: 100,
                                child: TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: 'min'),
                                  validator: (val) => val.isEmpty ? 'min' : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                              ),
                              SizedBox(width:5),
                              Text(":",style: basicLargeBlack,),
                              SizedBox(width:5),
                              Container(
                                width:58,
                                // height: 100,
                                child: TextFormField(
                                  decoration: textInputDecoration.copyWith(hintText: 'sec'),
                                  validator: (val) => val.isEmpty ? 'min' : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                              ),
                            ]
                          ),


                          Container(
                            padding: EdgeInsets.only(left:50, right: 50, bottom: 8, top:40),
                            alignment: Alignment.centerLeft,
                            child: Text("Included Zones:", style: TextStyle(fontSize:16)),
                          ),
                          Column(
                            children: [
                              
                              for (var i = 0; i < 5; i += 1)
                                Row(
                                  children: [
                                    Checkbox(
                                      onChanged: i == 4 ? null : (bool value) {
                                        setState(() {
                                          checked[i] = value;
                                        });
                                      },
                                      tristate: i == 1,
                                      value: checked[i],
                                      activeColor: Color(0xFF6200EE),
                                    ),
                                    Text(
                                      'Checkbox ${i + 1}',
                                      style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 4 ? Colors.black38 : Colors.black),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left:50, right: 50, bottom: 8, top:40),
                            alignment: Alignment.centerLeft,
                            child: Text("Occurence:", style: TextStyle(fontSize:16)),
                          ),
                          SizedBox(height: 20.0),
                          
                          SizedBox(height: 27.0),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text("Need an account, ", style: basicBlack,),
                          //     InkWell(
                          //       child: Text("Sign Up", style: basicBlue,),
                          //       onTap: () => widget.toggleView(),
                          //     ),
                          //     Text("!", style: basicBlack,)
                          //   ],
                          // ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(left:50, right:50,),
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                
                                decoration: BoxDecoration(
                                  color: sprinklerBlue,
                                  borderRadius: BorderRadius.circular(10),
                                  // boxShadow: [
                                  //   BoxShadow(color: Colors.green, spreadRadius: 3),
                                  // ],
                                ),
                                child: Text("Create Schedule", style: basicWhite,)
                              )
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          )
                        ]
                      )
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}




















