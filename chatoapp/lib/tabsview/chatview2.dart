import 'package:chato_app/frind_chat_screen.dart';
import 'package:chato_app/w_and_h.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chato_app/selectdata/add_n_f.dart';

class Chat_page2 extends StatefulWidget {
  @override
  _Chat_page2State createState() => _Chat_page2State();
}

class _Chat_page2State extends State<Chat_page2> {
  var instance_uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(instance_uid)
            .collection('frindes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return new ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat_screen(
                                snapshot.data.docs[index].data()['id'],
                                snapshot.data.docs[index].data()['username'],
                                snapshot.data.docs[index].data()['image'])));
                  },
                  child: SizedBox(
                    width: get_width(context),
                    height: get_height(context) / 10,
                    child: Card(
                      color: Colors.white,
                      shadowColor: Color.fromRGBO(55, 79, 71, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: get_height(context) / 25,
                                backgroundImage: NetworkImage(
                                    snapshot.data.docs[index].data()['image']),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      snapshot.data.docs[index]
                                          .data()['username'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      snapshot.data.docs[index]
                                          .data()['description'],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black54)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
