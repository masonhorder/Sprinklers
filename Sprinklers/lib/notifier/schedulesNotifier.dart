import 'package:Sprinklers/models/schedules.dart';
import 'dart:collection';
import 'package:flutter/cupertino.dart';


class SchedulesNotifier with ChangeNotifier {
  List<Schedules> _scheduleList = [];
  Schedules _currentSchedule;

  UnmodifiableListView<Schedules> get scheduleList => UnmodifiableListView(_scheduleList);

  Schedules get currentSchedules => _currentSchedule;

  set scheduleList(List<Schedules> scheduleList) {
    _scheduleList = scheduleList;
    notifyListeners();
  }

  set currentSchedule(Schedules schedules) {
    _currentSchedule = schedules;
    notifyListeners();
  }

  addSchedule(Schedules schedules) {
    scheduleList.insert(0, schedules);
    notifyListeners();
  }

  // deleteFood(Schedules schedule) {
  //   scheduleList.removeWhere((_schedules) => _schedules.id == schedule.id);
  //   notifyListeners();
  // }
}