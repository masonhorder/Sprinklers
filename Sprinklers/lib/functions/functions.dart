import 'package:flutter/material.dart';



scheduleTitle(String title){
  List charList;
  String returnTitle;
  int stringLength = title.length;
  if(stringLength >=12){
    returnTitle = title;
    while (returnTitle.length >= 13) {
      returnTitle = returnTitle.substring(0, returnTitle.length - 1);
    }
    if(returnTitle[11] == " "){
      returnTitle = returnTitle.substring(0, returnTitle.length - 1);
    }
    returnTitle = returnTitle + "...";
  }
  else{
    returnTitle = title;
  }

  return returnTitle;

}




startTime(int startTime){
  String hourStrStart;
  int hour;
  int minute;
  String hourStr;
  String minuteStr;
  String identifier;
  if(startTime >= 86400){
    return "error";
  }
  
  hourStrStart = (((startTime/60))/60).toString();
  String hourStrTime = hourStrStart.substring(0, hourStrStart.indexOf('.'));
  hour = int.parse(hourStrTime);
  minute = (startTime/60).round()-(hour*60);
  print((((startTime/60))/60));
  if(hour == 0){
    hourStr = "12";
    identifier = "AM";
  }
  else if(hour >= 12){
    hourStr = (hour-12).toString();
    identifier = "PM";
  }
  else{
    hourStr = hour.toString();
    identifier = "AM";
  }
  if(minute.toString().length == 1){
    minuteStr = "0" + minute.toString();
  }
  else{
    minuteStr = minute.toString();
  }

  return hourStr + ":" + minuteStr + " "+ identifier;
}