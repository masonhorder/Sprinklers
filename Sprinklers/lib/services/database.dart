import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/models/schedules.dart';
import 'package:Sprinklers/notifier/schedulesNotifier.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_init/after_init.dart';


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
  print(userId);
  print("data");
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('schedules')
      // .where("userId", isEqualTo: "")
      .get();

  List<Schedules> _schedulesList = [];

  snapshot.docs.forEach((document) {
    Schedules schedule = Schedules.fromMap(document.data());
    _schedulesList.add(schedule);
  });

  schedulesNotifier.scheduleList = _schedulesList;
}
