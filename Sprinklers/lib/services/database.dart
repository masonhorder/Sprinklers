import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/models/schedules.dart';
import 'package:Sprinklers/notifier/schedulesNotifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Sprinklers/models/build.dart';
import 'package:Sprinklers/notifier/buildNotifier.dart';
import 'package:Sprinklers/models/devices.dart';
import 'package:Sprinklers/notifier/deviceNotifier.dart';
import 'package:Sprinklers/models/scheduleForm.dart';
import 'package:Sprinklers/models/home.dart';



class DatabaseService {



  final String uid;
  DatabaseService({ this.uid });
  // print(uid);

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String firstName, String lastName) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc){
  //     //print(doc.data);
  //     return Brew(
  //       name: doc.data['name'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //       sugars: doc.data['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data()['firstName'],
      lastName: snapshot.data()['lastName'],
    );
  }

  // get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots()
  //     .map(_brewListFromSnapshot);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    // print(uid);
    return userCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}



















getSchedules(SchedulesNotifier schedulesNotifier, BuildContext context) async {
  UserID user = Provider.of<UserID>(context);
  String userId = user.uid;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('schedules')
      .where("userId", isEqualTo: userId)
      .get();

  List<Schedules> _schedulesList = [];

  snapshot.docs.forEach((document) {
    Schedules schedule = Schedules.fromMap(document.data());
    _schedulesList.add(schedule);
  });
  // print(_schedulesList);

  schedulesNotifier.scheduleList = _schedulesList;
}




getBuilds(BuildNotifier buildNotifier, BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('builds')
      .get();

  List<Builds> _buildList = [];

  snapshot.docs.forEach((document) {
    Builds build = Builds.fromMap(document.data());
    _buildList.add(build);
  });
  // print(_buildList);

  buildNotifier.buildList = _buildList;
}



getDevices(DevicesNotifier devicesNotifier, BuildContext context) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('devices')
      .get();

  List<Devices> _devicesList = [];

  snapshot.docs.forEach((document) {
    Devices devices = Devices.fromMap(document.data());
    _devicesList.add(devices);
  });
  // print(_devicesList);

  devicesNotifier.devicesList = _devicesList;
}


void deleteSchedule(){
  FirebaseFirestore.instance.collection("schedules").doc(ActiveSchedule.activeScheduleId).delete();
}

void addUser(String userId, int startTime, Map zones) async{
  DocumentReference ref = await FirebaseFirestore.instance.collection('schedules').add({
    'name': ScheduleFormParam.scheduleName, 
    'userId': userId,
    'deviceId': 1,
    'occurenceType': ScheduleFormParam.selectedOccurence,
    'startTime': startTime,
    'zones': zones
  }).catchError((error) => print("Failed to add schedule: $error"));
  // DocumentReference ref = await databaseReference.collection("books")
  //     .add({
  //       'title': 'Flutter in Action',
  //       'description': 'Complete Programming Guide to learn Flutter'
  //     });
  // print(ref.documentID);
}


submitForm(BuildContext context){
  UserID user = Provider.of<UserID>(context, listen: false);
  String userId = user.uid;
  int amPmTime = 0;
  List<List> zones = [];
  Map zonesMap = new Map();
  if(ScheduleFormParam.amPm[0] != true){
    amPmTime = 43200;
  }

  for(int i = 0; i < ScheduleFormParam.zoneNames.length; i++){
    if(ScheduleFormParam.selectedZones[i][0]){
      // print(ScheduleFormParam.selectedZones[i]);
      zones.add(ScheduleFormParam.selectedZones[i]);
    }
  }
  int startTime = (int.parse(ScheduleFormParam.startTimeMinute)*60)+(int.parse(ScheduleFormParam.startTimeHour)*60*60)+amPmTime;
  // print(zones);
  for(var item in zones){
    zonesMap[item[3].toString()] = {"zone":item[3],"runTime":((int.parse(item[1])*60)+(int.parse(item[2])))};
  }
  print(zonesMap);

  addUser(userId, startTime, zonesMap);
}
