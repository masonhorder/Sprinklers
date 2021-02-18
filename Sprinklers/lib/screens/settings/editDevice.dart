import 'package:Sprinklers/shared/loading.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:Sprinklers/functions/functions.dart';
import 'package:Sprinklers/notifier/buildNotifier.dart';
import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:Sprinklers/shared/constants.dart';




class EditDevicesSettings extends StatefulWidget {
  @override
  _EditDevicesSettingsState createState() => _EditDevicesSettingsState();
}

class _EditDevicesSettingsState extends State<EditDevicesSettings> {
  
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    BuildNotifier buildNotifier = Provider.of<BuildNotifier>(context, listen: false);
    getBuilds(buildNotifier,context);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  // String error = '';
  // bool loading = false;
  
  
  @override
  Widget build(BuildContext context) {
    int index = 0;
    // ScheduleFormParam.scheduleName = [];
    // for (var item in scheduleNotifier.scheduleList){
    //   ScheduleFormParam.scheduleName.add(item);
    //   index++;
    // }
    // BuildNotifier buildNotifier = Provider.of<BuildNotifier>(context);
    UserID user = Provider.of<UserID>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          // UserData userData = snapshot.data;
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
                            child: pageTitle(context, "Device", false, true, setState),
                          ),

                          SizedBox(height: 20.0),
                          // Image(image: AssetImage('images/sprinklerImage.png'), width: 90,),
                          SizedBox(height: 35.0),
                          Expanded(
                            child: SingleChildScrollView(
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
                                      decoration: textInputDecoration.copyWith(hintText: 'device name'),
                                      validator: (val) => val.isEmpty ? 'device name' : null,
                                      onChanged: (val) {
                                        setState(() => ScheduleFormParam.scheduleName = val);
                                      },
                                    ),
                                  ),
                                  


                                  Container(
                                    padding: EdgeInsets.only(left:50, right: 50, bottom: 8, top:40),
                                    alignment: Alignment.centerLeft,
                                    child: Text("Zones:", style: TextStyle(fontSize:16)),
                                  ),
                                  Container(
                                    // color: sprinklerBlue,
                                    padding: EdgeInsets.only(left:50,right:50),
                                    child: Column(
                                      children: [
                                        
                                        for (var i = 0; i < 5; i += 1)
                                          Row(
                                            children: [
                                              Checkbox(
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    ScheduleFormParam.selectedZones[i] = value;
                                                  });
                                                },
                                                value: ScheduleFormParam.selectedZones[i],
                                                activeColor: sprinklerBlue,
                                              ),
                                              Text(
                                                'Zone ${i + 1}',
                                                style: basicBlack,
                                              ),
                                            ],
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 42.0),
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
                                        child: Text("Save Changes", style: basicWhite,)
                                      )
                                    ),
                                  ),
                                  SizedBox(height: 12.0),
                                ]
                              )
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
        }else{
          return Loading();
        }
      }
    );      
  }
  choiceAction(String choice){
    if(choice == "Edit Device"){
      print("edit");
    }
    // else if(choice == "Subscribe"){
    //   print('Subscribe');
    // }
    // else if(choice == "Sign Out"){
    //   print('SignOut');
    // }
  }
}



