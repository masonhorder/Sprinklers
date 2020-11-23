class ScheduleFormParam{
  static String scheduleName = '';
  static String startTimeHour = '';
  static String startTimeMinute = '';
  static int startTimeAmPm = 0;
  static List selectedZones = [false, false, false, false, false,false,false,false,false, false, false, false, false,false,false,false];
  static List occurenceTypes = [[1,"Every Day"],[2,"Even Days"],[3,"Odd Days"],[4,"Week Days"],[5,"Weekends"],];
  static int selectedOccurence;
}