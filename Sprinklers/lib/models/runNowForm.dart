class RunNowFormParam{
  static int selectedRunType = 1;
  static List selectedZones = [];
  // static List selectedZoneTimes = [];
  static List<bool> amPm = [true, false];
  static List occurenceTypes = [[1,"Every Day"],[2,"Even Days"],[3,"Odd Days"],[4,"Week Days"],[5,"Weekends"],];
  static int selectedOccurence;
  static String errorMessage;
  static List zoneNames = [];
}