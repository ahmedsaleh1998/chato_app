import 'package:chato_app/hometabs.dart';
import 'package:chato_app/models/massagemode.dart';
import 'package:chato_app/tabsview/chatview2.dart';
import 'package:chato_app/w_and_h.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    TextEditingController massage = TextEditingController();
    String massagetext = "";
    FirebaseAuth instanse = FirebaseAuth.instance;
    final x = widget.frind_id;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(55, 130, 71, 0.7),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 9),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.frind_image),
              ),
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
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/backgroundchatimage.jpg'),
                  fit: BoxFit.cover)),
          ////////////////////////////
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    //  width: get_width(context),
                    height: get_height(context) * 0.79,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(instanse.currentUser.uid.trim())
                            .collection('frindes')
                            .doc(widget.frind_id.trim())
                            .collection('massages')
                            .orderBy('date')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          print(x);
                          return ListView.builder(
                              itemCount: snapshot.hasData
                                  ? snapshot.data.docs.length
                                  : 0,
                              itemBuilder: (_, index) {
                                // if (snapshot.data.docs[index]
                                //         .data()['sender'] ==
                                //     instanse.currentUser.uid) {
                                return Align(
                                  alignment: (snapshot.data.docs[index]
                                              .data()['sender'] ==
                                          instanse.currentUser.uid)
                                      ? Alignment.topLeft
                                      : Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (snapshot.data.docs[index]
                                                      .data()['sender'] ==
                                                  instanse.currentUser.uid)
                                              ? Colors.white
                                              : Colors.green[100],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0,
                                            bottom: 8.0,
                                            right: 10,
                                            left: 10),
                                        child: Text(
                                            "  " +
                                                snapshot.data.docs[index]
                                                    .data()['content'] +
                                                "  ",
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  ),
                  Container(
                    width: get_width(context),
                    height: get_height(context) * 0.09,
                    color: Colors.green[200],
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: get_width(context) / 9,
                          height: get_height(context) * 0.08,
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.send_rounded,
                            ),
                            onPressed: () {
                              setState(() {
                                massagetext = massage.text;
                              });
                              if (massagetext != null) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(instanse.currentUser.uid)
                                    .collection('frindes')
                                    .doc(widget.frind_id.trim())
                                    .collection('massages')
                                    .doc()
                                    .set({
                                  'sender': instanse.currentUser.uid,
                                  'resever': widget.frind_id.trim(),
                                  'date': DateTime.now(),
                                  'content': massagetext
                                });
                                //////////////////////////
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.frind_id.trim())
                                    .collection('frindes')
                                    .doc(instanse.currentUser.uid)
                                    .collection('massages')
                                    .doc()
                                    .set({
                                  'sender': instanse.currentUser.uid,
                                  'resever': widget.frind_id.trim(),
                                  'date': DateTime.now(),
                                  'content': massagetext
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: get_width(context) / 1.2,
                          height: get_height(context) * 0.07,
                          child: TextFormField(
                            controller: massage,
                            decoration: InputDecoration(
                              //   prefixIcon: Icon(Icons.lock),
                              hintText: 'Massage',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
