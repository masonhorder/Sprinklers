class ScheduleFormParam{
  static String scheduleName;
  static String startTimeHour;
  static String startTimeMinute;
  static List selectedZones = [];
  // static List selectedZoneTimes = [];
  static List<bool> amPm = [true, false];
  static List occurenceTypes = [[1,"Every Day"],[2,"Even Days"],[3,"Odd Days"],[4,"Week Days"],[5,"Weekends"],];
  static int selectedOccurence;
  static String errorMessage;
  static List zoneNames = [];
}
