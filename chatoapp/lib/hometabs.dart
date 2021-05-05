import 'package:chato_app/login.dart';
import 'package:chato_app/tabsview/addfrindview.dart';
import 'package:chato_app/tabsview/chatview.dart';
import 'package:chato_app/tabsview/chatview2.dart';
import 'package:chato_app/tabsview/statusview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class hometabs extends StatefulWidget {
  @override
  _hometabsState createState() => _hometabsState();
}

class _hometabsState extends State<hometabs> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(55, 79, 71, 1.0),
            title: Text('Chatoo app'),
            centerTitle: false,
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
            bottom: TabBar(
              isScrollable: false,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Chat'),
                      Icon(Icons.chat_rounded),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Status'),
                      Icon(Icons.sentiment_satisfied_outlined),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Friends'),
                      Icon(Icons.person),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Chat_page2(),
              Status_page(),
              Add_friend(),
            ],
          ),
        ),
      ),
    );
  }
}
