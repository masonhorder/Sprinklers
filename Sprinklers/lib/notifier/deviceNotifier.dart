import 'package:Sprinklers/models/devices.dart';
import 'dart:collection';
import 'package:flutter/cupertino.dart';


class DevicesNotifier with ChangeNotifier {
  List<Devices> _devicesList = [];
  Devices _currentDevices;

  UnmodifiableListView<Devices> get devicesList => UnmodifiableListView(_devicesList);

  Devices get currentDevices => _currentDevices;

  set devicesList(List<Devices> devicesList) {
    _devicesList = devicesList;
    notifyListeners();
  }

  set currentSchedule(Devices devices) {
    _currentDevices = devices;
    notifyListeners();
  }

  // addSchedule(Devices devices) {
  //   devicesList.insert(0, devices);
  //   notifyListeners();
  // }

  // deleteFood(Devices devices) {
  //   devicesList.removeWhere((_devices) => _devices.id == devices.id);
  //   notifyListeners();
  // }
}
