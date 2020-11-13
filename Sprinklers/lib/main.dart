import 'package:Sprinklers/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Sprinklers/screens/wrapper.dart';
import 'package:Sprinklers/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:Sprinklers/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Sprinklers/notifier/schedulesNotifier.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [

      ChangeNotifierProvider(
        create: (context) => SchedulesNotifier(),
      ),
    ],
    child: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {  
  
  @override
  Widget build(BuildContext context) {
    

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // this one for android
      statusBarBrightness: Brightness.light// this one for iOS
    ));
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Dice Coding Log',
      
    //   theme: ThemeData(
    //     accentColor: sprinklerBlue,
    //     scaffoldBackgroundColor: backgroundColor,
    //   ),
    //   home: DefaultTabController(
    //     length: 1,
    //     child: new Scaffold(
    //       body: TabBarView(
    //         children: [
    //           HomePage(),
    //         ],
    //       ),
    //       bottomNavigationBar: new TabBar(
    //         tabs: [
    //           Tab(
    //             icon: new Icon(Icons.analytics),
    //           ),
    //           // Tab(
    //           //   icon: new Icon(Icons.list),
    //           // ),
    //         ],
    //         labelColor: sprinklerBlue,
    //         unselectedLabelColor: sprinklerBlue,
    //         indicatorSize: TabBarIndicatorSize.label,
    //         indicatorPadding: EdgeInsets.all(5.0),
    //         indicatorColor: sprinklerBlue,
    //       ),
    //     ),
    //   ),      
    // );
    return StreamProvider<UserID>.value(
      value: AuthService().user,
      child: Theme(
        data: ThemeData(
          primaryColor: sprinklerBlue,
          accentColor: sprinklerBlue,
          hintColor: sprinklerBlue
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      )
    );
  }
}