import 'package:chat_app/helper/helperfunctions.dart';
import 'package:chat_app/views/chatRoomScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'helper/authenticate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
        setState(() {
          userIsLoggedIn = value;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Private Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff1a1d24),
        scaffoldBackgroundColor: Color(0xff1a1d24),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null  ? userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
        child: Center(
        child: Authenticate(),
        )
    )
    );
  }
}

