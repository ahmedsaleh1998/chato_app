import 'package:chato_app/hometabs.dart';
import 'package:chato_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => hometabs()));
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
