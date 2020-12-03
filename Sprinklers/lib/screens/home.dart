import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:Sprinklers/notifier/deviceNotifier.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sprinklers/functions/functions.dart';
import 'package:Sprinklers/screens/scheduleForm.dart';
import 'package:Sprinklers/models/home.dart';










class HomePage extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<HomePage>{
  UserID user;


  @override
  void initState() {
    DevicesNotifier devicesNotifier = Provider.of<DevicesNotifier>(context, listen: false);
    getDevices(devicesNotifier,context);
    super.initState();
  }

  
  // final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    UserID user = Provider.of<UserID>(context);
    DevicesNotifier devicesNotifier = Provider.of<DevicesNotifier>(context);
    getDevices(devicesNotifier,context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:Scaffold(

              body: Container(
                // color: Colors.blue,
                
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                  
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.0),
                      Container(
                        child: pageTitle(context, "Sprinklers", true, false, setState),
                      ),
                      SizedBox(height: 20,),
                      
                      Expanded(

                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          
                          child: Column(
                            children:[
                              SizedBox(height: 30,),

                              StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('schedules').where("userId", isEqualTo: userData.uid).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                  // for(var item in snapshot.data.docs){
                                  //   print(item.id);
                                  // }
                                  if(!snapshot.hasData){
                                    return Loading();
                                  }
                                  List schedulesList = snapshot.data.docs.toList();
                                  return Container(
                                    height: 140,
                                    
                                    // margin: EdgeInsets.only(left:15, right: 15),

                                          
                                    child: ListView.builder(
                                      // shrinkWrap: true,
                                      clipBehavior: Clip.none,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: schedulesList.length + 1,
                                      itemBuilder: (context, index){
                                        if(schedulesList.length + 1 != 1){
                        
                                          if(index == schedulesList.length){
                                            return Row(
                                              children:[
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
                                                      onPressed: () async{
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => ScheduleForm()),
                                                        );
                                                      },
                                                    )
                                                    
                                                  )
                                                ),
                                                SizedBox(width:15),
                                              ]
                                            );
                                          }
                                          // print(schedulesList[index]["id"]);
                                          return Row(
                                            children: [
                                              SizedBox(width:15),

                                              Container(
                                                padding: EdgeInsets.all(6),
                                                width:180,
                                                height: 110,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children:[
                                                        Container(
                                                          child: Text(limitString(schedulesList[index]["name"], 12), style: basicBlack,),
                                                        ),
                                                      
                                                        Material(
                                                          
                                                          type: MaterialType.circle,
                                                          clipBehavior: Clip.hardEdge,
                                                          color: Colors.transparent,
                                                          child: PopupMenuButton<String>(
                                                            
                                                            child: Icon(Icons.more_vert),
                                                            onSelected: choiceAction,
                                                            itemBuilder: (BuildContext context){
                                                              return ["Edit Schedule", "Run Now", "Delete Schedule", "Pause Schedule"].map((String choice){
                                                                ActiveSchedule.activeScheduleId = schedulesList[index].id;
                                                                return PopupMenuItem<String>(
                                                                  value: choice,
                                                                  child: Text(choice, style: basicSmallBlack,),
                                                                );
                                                              }).toList();
                                                            },
                                                          )
                                                        )


                                                      ]
                                                    ),
                                                    SizedBox(height:8),
                                                    Container(
                                                      child: Row(
                                                        children:[
                                                          Text("Start Time: " + startTime(schedulesList[index]["startTime"]), style: basicSmallBlack)
                                                        ]
                                                      )
                                                    ),
                                                    SizedBox(height:9),
                                                    Container(
                                                      child: Row(
                                                        children:[
                                                          Text("Occurence: " + occurenceType(schedulesList[index]["occurenceType"]), style: basicSmallBlack)
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
                                        }else{
                                          return Container(
                                            width: MediaQuery.of(context).size.width,
                                            child:Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:[
                                                Text("It seems like you have no schedules right now!", style: basicSmallBlack,),
                                                SizedBox(height:27),
                                                InkWell(
                                                  
                                                  
                                                  child: Container(
                                                    
                                                    padding: EdgeInsets.all(16),
                                                    child: Text("Create Schedule", style: basicSmallBlack,),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(color: sprinklerBlue, spreadRadius: 2),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () async{
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(builder: (context) => ScheduleForm()),
                                                    );
                                                  },
                                                )
                                              ]
                                            )
                                          );

                                        }
                                      }
                                    )
                                  );
          
                                }
                              ),

                              SizedBox(
                                height: 50,
                              ),

                              Container(
                                
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text('Run History', style: basicLargeBlack),
                                      ),

                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection('runHistory').where("userId", isEqualTo: userData.uid).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                          if(!snapshot.hasData){
                                            return Loading();
                                          }
                                          List schedulesList = snapshot.data.docs.toList();
                                          return Container(
                                            height: 340,
                                            
                                            margin: EdgeInsets.only(left:15, right: 15),

                                                  
                                          child: ListView.builder(
                                            // scrollDirection: Axis.horizontal,
                                            itemCount: schedulesList.length,
                                            itemBuilder: (context, index){
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 1,
                                                    color: lightGrey,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(runHistoryTitle(schedulesList[index]["runType"], schedulesList[index]["startTime"], schedulesList[index]["duration"]),style: basicBlackBold,),
                                                  ),
                                                ]
                                              );
                                            })
                                          );
                  
                                        }
                                      ),

                                      
                                      
                                    ]
                                  )
                                ),
                                height: 400,
                                margin: EdgeInsets.only(left: 15, right:15),
                                width: MediaQuery.of(context).size.width,
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
                              )
                            ]
                          )
                        )
                      )
                    ]
                  )
                ),
              )
            )
          );
        }
        return Loading();
      }
    );      
  }

  void choiceAction(String choice){
    print("action");
    print(ActiveSchedule.activeScheduleId);

    if(choice == "Delete Schedule"){
      deleteSchedule();
    }
    // if(choice == "Settings"){
    //   print('Settings');
    // }else if(choice == "Subscribe"){
    //   print('Subscribe');
    // }else if(choice == "Sign Out"){
    //   print('SignOut');
    // }
  }








}



