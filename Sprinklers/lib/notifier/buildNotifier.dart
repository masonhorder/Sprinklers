import 'package:Sprinklers/models/build.dart';
import 'dart:collection';
import 'package:flutter/cupertino.dart';


class BuildNotifier with ChangeNotifier {
  List<Builds> _buildList = [];
  // Schedules _currentSchedule;

  UnmodifiableListView<Builds> get buildList => UnmodifiableListView(_buildList);


  set buildList(List<Builds> scheduleList) {
    _buildList = scheduleList;
    notifyListeners();
  }

  // set currentSchedule(Schedules schedules) {
  //   _currentSchedule = schedules;
  //   notifyListeners();
  // }

  // addSchedule(Schedules schedules) {
  //   scheduleList.insert(0, schedules);
  //   notifyListeners();
  // }
}