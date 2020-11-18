import 'package:Sprinklers/notifier/schedulesNotifier.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:provider/provider.dart';
import 'package:Sprinklers/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sprinklers/models/schedules.dart';
import 'package:Sprinklers/functions/functions.dart';






class DevicesSettings extends StatefulWidget {
  @override
  _DevicesSettingsState createState() => _DevicesSettingsState();
}

class _DevicesSettingsState extends State<DevicesSettings> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  

  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 40.0),
                    Container(
                      child: pageTitle(context, "Devices", false, true),
                    ),
                    SizedBox(height: 40.0),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('devices').where("userId", isEqualTo: userData.uid).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if(!snapshot.hasData){
                          return Loading();
                        }
                        List schedulesList = snapshot.data.docs.toList();
                        return Container(
                          
                          // margin: EdgeInsets.only(left:5, right: 5),

                                
                          child: ListView.builder(
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            itemCount: schedulesList.length + 1,
                            itemBuilder: (context, index){
                              if(index == schedulesList.length){

                                return Column(
                                  children:[
                                    SizedBox(height: 40.0),
                                    Material(
                                      type: MaterialType.circle,
                                      clipBehavior: Clip.hardEdge,
                                      color: Colors.transparent,
                                      child: Container(
                                        color: sprinklerBlue,
                                        child: IconButton(
                                        
                                          icon: Icon(Icons.add),
                                          iconSize: 50,
                                          color: Colors.white,
                                          onPressed: (){},
                                        )
                                        
                                      )
                                    )
                                  ]
                    );
                              }
                              return Column(
                                children: [
                                  SizedBox(height:20),

                                  Container(
                                    margin: EdgeInsets.only(left:15,right:15),
                                    padding: EdgeInsets.all(6),
                                    // width:180,
                                    height: 180,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                            Container(
                                              child: Text(limitString(schedulesList[index]["name"],17), style: basicLargeBlack,),
                                            ),
                                          
                                            Material(
                                              
                                              type: MaterialType.circle,
                                              clipBehavior: Clip.hardEdge,
                                              color: Colors.transparent,
                                              child: PopupMenuButton<String>(
                                                
                                                child: Icon(Icons.more_vert, size: 30,),
                                                // onSelected: choiceAction,
                                                itemBuilder: (BuildContext context){
                                                  return ["Forget Device", "Edit Name", "Delete Data", "Pause Device"].map((String choice){
                                                    return PopupMenuItem<String>(
                                                      value: choice,
                                                      child: Text(choice, style: basicBlack,),
                                                    );
                                                  }).toList();
                                                },
                                              )
                                            )


                                          ]
                                        ),
                                        // SizedBox(height:8),
                                        // Container(
                                        //   child: Row(
                                        //     children:[
                                        //       Text("Start Time: ", style: basicBlack)
                                        //     ]
                                        //   )
                                        // ),
                                        SizedBox(height:9),
                                        Container(
                                          child: Row(
                                            children:[
                                              Text("Number of Zones: 8", style: basicBlack)
                                            ]
                                          )
                                        )
                                      ]
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width:20)
                                ]

                                  
                              );
                            }
                          )
                        );

                      }
                    ),

                  ]
                ),
              ),
            )
          );
        }else{
          return Loading();
        }
      }
    );      
  }
}



