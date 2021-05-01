import 'package:chato_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "home",
        home: Scaffold(
          appBar: AppBar(
            title: Text('Chato App'),
            centerTitle: true,
            actions: [
              //BackButtonIcon(),
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    await instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }),
            ],
          ),
          body: Container(),
        ));
  }
}
