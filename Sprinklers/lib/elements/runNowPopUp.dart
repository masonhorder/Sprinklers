import 'package:Sprinklers/notifier/deviceNotifier.dart';
import 'package:Sprinklers/screens/settings.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/models/runNowForm.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:Sprinklers/shared/constants.dart';
import 'package:Sprinklers/functions/functions.dart';

zoneRunTime(BuildContext contex, StateSetter setState, bool checked, int index){
  String initialSecond;
  String initialMinute;
  if(RunNowFormParam.selectedZones[index][2] == 0){
    initialSecond = "";
  }
  else{
    initialSecond = RunNowFormParam.selectedZones[index][2].toString();
  }
  if(RunNowFormParam.selectedZones[index][1] == 0){
    initialMinute = "";
  }
  else{
    initialMinute = RunNowFormParam.selectedZones[index][1].toString();
  }
  // initialSecond = ScheduleFormParam.selectedZones[index][2];
  // intialMinute = ScheduleFormParam.selectedZones[index][1];

  if(checked){
    return Row(
      children: [
        // Text("hi"),
        SizedBox(width:10),
        Container(
          width:58,
          // height: 100,
          child: TextFormField(
            initialValue: initialMinute,
            decoration: textInputDecoration.copyWith(hintText: 'min'),
            validator: (val) => val.isEmpty ? 'min' : null,
            onChanged: (val) {
              setState(() => RunNowFormParam.selectedZones[index][1] = val);
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
            initialValue: initialSecond,
            decoration: textInputDecoration.copyWith(hintText: 'sec'),
            validator: (val) => val.isEmpty ? 'sec' : null,
            onChanged: (val) {
              setState(() => RunNowFormParam.selectedZones[index][2] = val);
            },
          ),
        ),
      ]
    );
  }
  else{
    return SizedBox(width: 1);
  }
}



mainBody(StateSetter setState, DevicesNotifier devicesNotifier, BuildContext context,){
  if(RunNowFormParam.selectedRunType == 1){
    RunNowFormParam.zoneNames = [];
    // ScheduleFormParam.selectedZones = [];
    int index = 0;
    if(devicesNotifier.devicesList[0].zones.length > 1){
      for (var item in devicesNotifier.devicesList[0].zones){
        RunNowFormParam.zoneNames.add(item);
        RunNowFormParam.selectedZones.add([false, 0, 0, index]);
        index++;
      }
      return Container(
        // color: sprinklerBlue,
        alignment: Alignment.centerLeft,
        child: Column( 
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text("Select Zone:"),
            Container(
                // color: sprinklerBlue,
              // padding: EdgeInsets.only(left:30,right:30),
              child: Column(
                children: [
                  
                  for (var i = 0; i < RunNowFormParam.zoneNames.length; i += 1)
                  Container(
                    margin: EdgeInsets.only(top:3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                setState(() {
                                  RunNowFormParam.selectedZones[i][0] = value;
                                });
                              },
                              value: RunNowFormParam.selectedZones[i][0],
                              activeColor: sprinklerBlue,
                            ),
                            Text(
                              limitString(RunNowFormParam.zoneNames[i],11),
                              style: basicBlack,
                            ),
                          ]
                        ),



                        zoneRunTime(context, setState, RunNowFormParam.selectedZones[i][0], i),
                        
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      );  
    } 
  }
  else{
    return Container(
      // color: sprinklerBlue,
      alignment: Alignment.centerLeft,
      child: Column( 
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text("Select Schedule:"),
          Container(
              // color: sprinklerBlue,
            // padding: EdgeInsets.only(left:30,right:30),
            child: Text(""),
          ),
        ]
      ),
    );    
  }
}




runNowPopUp(BuildContext context, StateSetter setState, DevicesNotifier devicesNotifier){
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Run Now'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Run Type:'),
                  Row(
                    children: [
                      Radio(
                        groupValue: RunNowFormParam.selectedRunType,
                        onChanged: (var value) {
                          setState((){
                            RunNowFormParam.selectedRunType = value;
                          });
                        },
                        value: 0,
                        activeColor: sprinklerBlue,
                      ),
                      Text("Schedule"),

                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    children: [
                      Radio(
                        groupValue: RunNowFormParam.selectedRunType,
                        onChanged: (var value) {
                          setState((){
                            RunNowFormParam.selectedRunType = value;
                          });
                        },
                        value: 1,
                        activeColor: sprinklerBlue,
                      ),
                      Text("Zone"),

                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  SizedBox(height:17),

                  mainBody(setState, devicesNotifier, context,),
                ],
              ),
            );
          }
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {
              // await _auth.signOut();
              // Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Run'),
            onPressed: () async {
              // await _auth.signOut();
              // Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          
        ],
      );
    },
  );
}