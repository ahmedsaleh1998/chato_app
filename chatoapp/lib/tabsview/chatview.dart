import 'package:chato_app/w_and_h.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chato_app/selectdata/add_n_f.dart';

class Chat_page extends StatefulWidget {
  @override
  _Chat_pageState createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {
  var instance_uid = FirebaseAuth.instance.currentUser.uid;
  List<String> frindesid = [];
  // var c_instanse = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(instance_uid)
        .collection('frindes')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        frindesid.add(doc['id']);
        for (int i = 0; i < frindesid.length; i++) {
          print(frindesid[i]);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var c_instanse = FirebaseFirestore.instance.collection('users').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: c_instanse,
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
              // return new ListTile(
              //   title: new Text(snapshot.data.docs[index].data()['username']),
              //   subtitle:
              //       new Text(snapshot.data.docs[index].data()['description']),
              //   onTap: () {
              //     print(snapshot.data.docs[index].data()['username']);
              //   },
              // );
              for (int i = 0; i < frindesid.length; i++) {
                if (frindesid[i] == snapshot.data.docs[index].data()['id']) {
                  return GestureDetector(
                    child: SizedBox(
                      width: get_width(context),
                      height: get_height(context) / 10,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(snapshot.data.docs[index]
                                      .data()['username']),
                                  Text(snapshot.data.docs[index]
                                      .data()['description']),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: get_height(context) / 25,
                                backgroundImage: NetworkImage(
                                    snapshot.data.docs[index].data()['image']),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          );
        });
  }
}
