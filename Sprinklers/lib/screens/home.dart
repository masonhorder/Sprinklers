import 'package:Sprinklers/notifier/schedulesNotifier.dart';
import 'package:Sprinklers/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:Sprinklers/elements/pageTitle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:Sprinklers/services/database.dart';
import 'package:provider/provider.dart';
import 'package:Sprinklers/services/auth.dart';










class HomePage extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<HomePage>{
  UserID user;
  @override
  void initState() {
    SchedulesNotifier schedulesNotifier = Provider.of<SchedulesNotifier>(context, listen: false);
    getSchedules(schedulesNotifier,context);
    super.initState();
  }

  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int first = 1;
  Stream<int> _scheduleListsStream = ((int first) async* {
    if(first == 1)
    await Future<void>.delayed(Duration(seconds: 1));
  })(first);

  @override
  Widget build(BuildContext context) {
    SchedulesNotifier schedulesNotifier = Provider.of<SchedulesNotifier>(context, listen: false);
    getSchedules(schedulesNotifier,context);
    UserID user = Provider.of<UserID>(context);
    
    

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        getSchedules(schedulesNotifier, context);
        print(schedulesNotifier);
        getSchedules(schedulesNotifier, context);
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Scaffold(

            body: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 40.0),
                  Container(
                    child: pageTitle(context, "Sprinklers", true, false),
                  ),
                  Expanded(
                    
                    child: StreamBuilder(
                      stream: _scheduleListsStream,
                      builder:(BuildContext context, AsyncSnapshot<int> snapshot){
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            print(index);
                            return Container(
                              child: Text(schedulesNotifier.scheduleList[index].name),
                              color: Colors.red,
                              // child: Text("hi"),
                            );
                          },
                          itemCount: schedulesNotifier.scheduleList.length,
                        );
                      }
                    )
                  )
                ]
              ),
            )
          );
        }
        return Loading();
      }
    );      
  }
}



