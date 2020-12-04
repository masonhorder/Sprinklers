import 'package:Sprinklers/shared/constants.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:flutter/services.dart';
import 'package:Sprinklers/elements/scheduleFormExtras.dart';
import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:Sprinklers/functions/functions.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:Sprinklers/models/devices.dart';
import 'package:Sprinklers/notifier/deviceNotifier.dart';
import 'package:provider/provider.dart';



class ScheduleForm extends StatefulWidget {

  final Function toggleView;
  ScheduleForm({ this.toggleView });

  @override
  _ScheduleFormState createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  
  // final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;


  @override
  void initState(){
    DevicesNotifier devicesNotifier = Provider.of<DevicesNotifier>(context, listen: false);
    getDevices(devicesNotifier,context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));
    DevicesNotifier devicesNotifier = Provider.of<DevicesNotifier>(context);
    getDevices(devicesNotifier,context);

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
                      child: pageTitle(context, "Schedule", false, true, setState),
                    ),

                    SizedBox(height: 20.0),
                    // Image(image: AssetImage('images/sprinklerImage.png'), width: 90,),
                    SizedBox(height: 35.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children:[

                            Container(
                              padding: EdgeInsets.only(left:30, right: 30, bottom: 8),
                              alignment: Alignment.centerLeft,
                              child: Text("Name:", style: TextStyle(fontSize:16)),
                            ),
                            Container(
                              padding: EdgeInsets.only(left:30, right: 30),
                              child: TextFormField(
                                initialValue: ScheduleFormParam.scheduleName,
                                decoration: textInputDecoration.copyWith(hintText: 'schedule name'),
                                validator: (val) => val.isEmpty ? 'schedule name' : null,
                                onChanged: (val) {
                                  setState(() => ScheduleFormParam.scheduleName = val);
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left:30, right: 30, bottom: 8, top:40),
                              alignment: Alignment.centerLeft,
                              child: Text("Start Time:", style: TextStyle(fontSize:16)),
                            ),
                            Row(
                              children: [
                                // Text("hi"),
                                SizedBox(width:30),
                                Container(
                                  width:58,
                                  // height: 100,
                                  child: TextFormField(
                                    initialValue: ScheduleFormParam.startTimeHour,
                                    decoration: textInputDecoration.copyWith(hintText: 'hr'),
                                    validator: (val) => val.isEmpty ? 'hr' : null,
                                    onChanged: (val) {
                                      setState(() => ScheduleFormParam.startTimeHour = val);
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
                                    initialValue: ScheduleFormParam.startTimeMinute,
                                    decoration: textInputDecoration.copyWith(hintText: 'min'),
                                    validator: (val) => val.isEmpty ? 'min' : null,
                                    onChanged: (val) {
                                      setState(() => ScheduleFormParam.startTimeMinute = val);
                                    },
                                  ),
                                ),
                                SizedBox(width:20),
                                // ToggleSwitch(
                                //   minWidth: 50,
                                //   minHeight: 40,
                                //   fontSize: 16.0,
                                //   initialLabelIndex: 0,
                                //   activeBgColor: sprinklerBlue,
                                //   activeFgColor: whiteFontColor,
                                //   inactiveBgColor: whiteFontColor,
                                //   inactiveFgColor: Colors.grey[900],
                                //   labels: ['AM', 'PM'],
                                //   onToggle: (index) {
                                //     // print('switched to: $index');
                                //   },
                                // )

                                ToggleButtons(
                                  children: <Widget>[
                                    Text("AM"),
                                    Text("PM"),
                                    // Icon(Icons.cake),
                                  ],
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex < ScheduleFormParam.amPm.length; buttonIndex++) {
                                        if (buttonIndex == index) {
                                          ScheduleFormParam.amPm[buttonIndex] = true;
                                        } else {
                                          ScheduleFormParam.amPm[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                  isSelected: ScheduleFormParam.amPm,
                                ),
                              ]
                            ),


                            Container(
                              padding: EdgeInsets.only(left:30, right: 30, bottom: 8, top:40),
                              alignment: Alignment.centerLeft,
                              child: Text("Included Zones:", style: TextStyle(fontSize:16)),
                            ),
                            Container(
                              // color: sprinklerBlue,
                              padding: EdgeInsets.only(left:30,right:30),
                              child: zoneSelection(setState, devicesNotifier, context, false),
                            ),

                            
                            Container(
                              padding: EdgeInsets.only(left:30, right: 30, bottom: 8, top:40),
                              alignment: Alignment.centerLeft,
                              child: Text("Occurence:", style: TextStyle(fontSize:16)),
                            ),
                            Container(
                              // color: sprinklerBlue,
                              padding: EdgeInsets.only(left:30,right:30),
                              child: Column(
                                children: [
                                  
                                  for (var item in ScheduleFormParam.occurenceTypes)
                                    Row(
                                      children: [
                                        Radio(
                                          groupValue: ScheduleFormParam.selectedOccurence,
                                          onChanged: (var value) {
                                            setState(() {
                                              ScheduleFormParam.selectedOccurence = value;
                                            });
                                          },
                                          value: item[0],
                                          activeColor: sprinklerBlue,
                                        ),
                                        Text(item[1],style: basicBlack,),

                                      ],
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 50.0),
                                                        
                            scheduleFormError(),

                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: ((){
                                  if(validateSchedule() == true){
                                    submitForm(context);
                                    ScheduleFormParam.selectedOccurence = null;
                                    ScheduleFormParam.startTimeMinute = null;
                                    ScheduleFormParam.startTimeHour = null;
                                    ScheduleFormParam.scheduleName = null;
                                    ScheduleFormParam.selectedZones = [];
                                    ScheduleFormParam.amPm = [true, false];
                                    Navigator.pop(context,);
                                  }
                                  else{
                                    setState(() {
                                      ScheduleFormParam.errorMessage = validateSchedule();
                                    });
                                  }
                                }),
                                child: Container(
                                  margin: EdgeInsets.only(left:30, right:30,),
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




















