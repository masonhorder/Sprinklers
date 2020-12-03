import 'package:Sprinklers/screens/settings.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/models/runNowForm.dart';
import 'package:Sprinklers/style/style.dart';
import 'package:Sprinklers/shared/constants.dart';


runNowPopUp(BuildContext context, StateSetter setState){
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Run Now'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Run Type:'),
              Row(
                children: [
                  Radio(
                    groupValue: RunNowFormParam.currentValue,
                    onChanged: (var value) {
                      // setState((){
                        RunNowFormParam.currentValue = value;
                      // });
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
                    groupValue: RunNowFormParam.currentValue,
                    onChanged: (var value) {
                      // setState((){
                        RunNowFormParam.currentValue = value;
                      // });
                    },
                    value: 1,
                    activeColor: sprinklerBlue,
                  ),
                  Text("Zone"),

                ],
                // mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(height:17),
              Text("Select Zone:"),
              Column(
                children: [
                  
                  for (var i = 0; i < 12; i += 1)
                    Row(
                      children: [
                        Checkbox(
                          onChanged: (bool value) {
                            // setState(() {
                              RunNowFormParam.selectedZones[i] = value;
                            // });
                          },
                          value: RunNowFormParam.selectedZones[i],
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
              Row(
                children: [
                  // Text("hi"),
                  SizedBox(width:50),
                  Container(
                    width:58,
                    // height: 100,
                    child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: 'hr'),
                      validator: (val) => val.isEmpty ? 'hr' : null,
                      onChanged: (val) {
                        setState(() => RunNowFormParam.startTimeHour = val);
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
                      decoration: textInputDecoration.copyWith(hintText: 'min'),
                      validator: (val) => val.isEmpty ? 'min' : null,
                      onChanged: (val) {
                        setState(() => RunNowFormParam.startTimeMinute = val);
                      },
                    ),
                  ),
                ]
              ),
            ],
          ),
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