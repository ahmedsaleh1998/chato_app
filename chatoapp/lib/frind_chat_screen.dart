import 'package:chato_app/hometabs.dart';
import 'package:chato_app/tabsview/chatview2.dart';
import 'package:chato_app/w_and_h.dart';
import 'package:flutter/material.dart';

class Chat_screen extends StatefulWidget {
  String frind_id;
  String frind_image;
  String frind_username;
  Chat_screen(this.frind_id, this.frind_username, this.frind_image);

  @override
  _Chat_screenState createState() => _Chat_screenState();
}

class _Chat_screenState extends State<Chat_screen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.frind_image),
            )
          ],
          title: Text(widget.frind_username),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => hometabs()));
                },
              );
            },
          ),
        ),
        body: Container(
          width: get_width(context),
          height: get_height(context),
          child: Column(
            children: [
              Container(
                width: get_width(context),
                height: get_height(context) * 0.79,
                color: Colors.black,
              ),
              Container(
                width: get_width(context),
                height: get_height(context) * 0.09,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
