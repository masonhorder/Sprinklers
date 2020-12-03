import 'package:date_format/date_format.dart';
import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:Sprinklers/notifier/buildNotifier.dart';

limitString(String title, int length){
  String returnTitle;
  int stringLength = title.length;
  if(stringLength >=length){
    returnTitle = title;
    while (returnTitle.length >= length+1) {
      returnTitle = returnTitle.substring(0, returnTitle.length - 1);
    }
    if(returnTitle[length-1] == " "){
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
  // print((((startTime/60))/60));
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



occurenceType(int occurence){
  String returnString;
  switch(occurence) { 
    case 1: { 
      returnString = "Everyday";
    } 
    break; 
  
    case 2: { 
      returnString = "Even Days";
    } 
    break; 

    case 3: { 
      returnString = "Odd Days";
    } 
    break; 
      
      
  //  default: { 
  //     //statements;  
  //  }
  //  break; 
  } 
  if(returnString == null){
    returnString = "error";
  }
  return returnString;
}















convertStringToDate(int strDate){
  DateTime date = DateTime.fromMillisecondsSinceEpoch(strDate*1000);
  return date;
}

runHistoryTitle(int runType, int startTime, int duration){
  List runHistoryTitleList = [];
  
  double dblMinutes = duration/1000/60;
  int minutes = dblMinutes.round();
  DateTime date = convertStringToDate(startTime);
  String timeIdentifier;
  int timeInt = minutes;


  // name of either zone or schedule
  if(runType == 0){
    runHistoryTitleList.add("Zone 1:");
  }
  else{
    runHistoryTitleList.add("Schedule 1:");
  }

  
  runHistoryTitleList.add(formatDate(date, [hh, ':', nn, ' ', am, ', ', M, ' ', dd]));


  if(runType == 0){
    if(minutes > 57){
      double dblHours = minutes/60;
      int hours = dblHours.round();
      timeInt = hours;
      if(hours != 1){
        timeIdentifier = "Hours";
      } else{
        timeIdentifier = "Hour";
      }
    }else{
      if(minutes != 1){
        timeIdentifier = "Minutes";
      } else{
        timeIdentifier = "Minute";
      }
    }
    runHistoryTitleList.add(timeInt.toString() +  " " +  timeIdentifier);
  }

  return runHistoryTitleList.join(" ");
}




getZoneCount(int buildId, BuildNotifier buildNotifier){
  int index = 0;
  for(var item in buildNotifier.buildList){
    // print(item.zones);
    if(item.buildId == buildId){
      return item.zones.toString();
    }
    index += 1;
  }
  return "error retreiving data";
}



validateSchedule(){
  List returnList = [];
  bool errors = false;
  bool selectedZones = false;
  if(ScheduleFormParam.scheduleName == null || ScheduleFormParam.scheduleName == ""){
    errors = true;
    returnList.add("Name Required");
  }

  if(ScheduleFormParam.startTimeMinute == null || ScheduleFormParam.startTimeHour == null || ScheduleFormParam.startTimeMinute == "" || ScheduleFormParam.startTimeHour == "" || int.parse(ScheduleFormParam.startTimeMinute) > 59 || int.parse(ScheduleFormParam.startTimeHour) > 12){
    errors = true;
    returnList.add("Invalide Start Time");
  }

  if(ScheduleFormParam.selectedOccurence == null){
    errors = true;
    returnList.add("Occurence Required");
  }

  for(int index = 0; index <  ScheduleFormParam.zoneNames.length; index++){
    
    if(ScheduleFormParam.selectedZones[index][0]){
      selectedZones = true;
      if(ScheduleFormParam.selectedZones[index][1] == "" || ScheduleFormParam.selectedZones[index][1] == null || ScheduleFormParam.selectedZones[index][1] == 0 || ScheduleFormParam.selectedZones[index][2] == "" || ScheduleFormParam.selectedZones[index][2] == null || ScheduleFormParam.selectedZones[index][2] == 0){
        returnList.add("Invalid Zone Run Time");
        errors = true;
      }
    }
    // else{}
    index++;
  }
  if(!selectedZones){
    returnList.add("Need atleast 1 zone");
    errors = true;
  }

  if(errors == true){
    String returnString = "";
    int index = 0;
    if(returnList.length == 1){
      returnString = returnList[0];
    }
    else{
      for(var error in returnList){
        if(index+1 == returnList.length){
          returnString += error;
        }
        else{
          returnString += error + ", ";
        }

        index++;
      }
    }
    return returnString;
  }
  return true;
}