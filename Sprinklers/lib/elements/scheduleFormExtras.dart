import 'package:Sprinklers/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:Sprinklers/shared/constants.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:Sprinklers/notifier/deviceNotifier.dart';
import 'package:Sprinklers/functions/functions.dart';

zoneRunTime(BuildContext contex, StateSetter setState, bool checked, int index){
  String initialSecond;
  String initialMinute;
  if(ScheduleFormParam.selectedZones[index][2] == 0){
    initialSecond = "";
  }
  else{
    initialSecond = ScheduleFormParam.selectedZones[index][2].toString();
  }
  if(ScheduleFormParam.selectedZones[index][1] == 0){
    initialMinute = "";
  }
  else{
    initialMinute = ScheduleFormParam.selectedZones[index][1].toString();
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
              setState(() => ScheduleFormParam.selectedZones[index][1] = val);
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
              setState(() => ScheduleFormParam.selectedZones[index][2] = val);
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





zoneSelection(StateSetter setState, DevicesNotifier devicesNotifier, BuildContext context){
  // print(devicesNotifier.devicesList);/
  // print(devicesNotifier.devicesList[0].zones);
  ScheduleFormParam.zoneNames = [];
  // ScheduleFormParam.selectedZones = [];
  int index = 0;
  if(devicesNotifier.devicesList[0].zones.length > 1){
    for (var item in devicesNotifier.devicesList[0].zones){
      ScheduleFormParam.zoneNames.add(item);
      ScheduleFormParam.selectedZones.add([false, 0, 0, index]);
      index++;
    }
    return Column(
      children: [
        
        for (var i = 0; i < ScheduleFormParam.zoneNames.length; i += 1)
        Container(
          margin: EdgeInsets.only(top:3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        ScheduleFormParam.selectedZones[i][0] = value;
                      });
                    },
                    value: ScheduleFormParam.selectedZones[i][0],
                    activeColor: sprinklerBlue,
                  ),
                  Text(
                    limitString(ScheduleFormParam.zoneNames[i],11),
                    style: basicBlack,
                  ),
                ]
              ),



              zoneRunTime(context, setState, ScheduleFormParam.selectedZones[i][0], i),
              
            ]
          ),
        ),
      ],
    );
  }
  return Loading();
}


scheduleFormError(){
  if(ScheduleFormParam.errorMessage != null){
    return Container(
      margin: EdgeInsets.only(left:30, right:30, bottom: 20),
      child:Text(ScheduleFormParam.errorMessage, style: error, textAlign: TextAlign.center,),
    );
  }
  else{
    return Container(
      margin: EdgeInsets.only(left:30, right:30),
      child:Text("-", style: TextStyle(color: Colors.transparent),),
    );
  }
}