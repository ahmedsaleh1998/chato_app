import 'package:chato_app/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Future<List<DocumentSnapshot>> addfriend(String userid, num phonenumber) {
//   List<user> allusers;
//   // return StreamBuilder<QuerySnapshot>(
//   //     stream: FirebaseFirestore.instance.collection('users').snapshots(),
//   //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
//   //       return ListView(
//   //         children:snapshots.data.docs.map((DocumentSnapshot document){

//   //         } ).toList(),
//   //       );

//   var data = FirebaseFirestore.instance.collection('users').doc().get();

//   return data.;
// }

// Future<Stream<QuerySnapshot>> returnallusers() async {
//   var users = await FirebaseFirestore.instance.collection('users').snapshots();

//   return users;
// }

// findornot(String userid, num phone) async {
//   bool findphone = false;
//   returnallusers().then((snapshot) {
//     for (int i = 0; i < snapshot.data.docs.length; i++) {

//     }
//   });
// }
// Future<List<User>> getallusers()  async {

//    QuerySnapshot userssnapshot=await FirebaseFirestore.instance.collection('users').get();
//    return userssnapshot.docs.map((e) => user(e.data()['username'],e.data()['description'],e.data()['image'],e.data()['phone'],e.data()['email'],e.data()['frindes'],e.data()['id'],)).toList();
// }
//
//
//
//
// //////////////////////////////////////////////////////
// Stream<List<user>> getallusers() {
//   Stream<QuerySnapshot> stream =
//       FirebaseFirestore.instance.collection('users').snapshots();
//   return stream.map((qShot) => qShot.docs.map((doc) {
//         return user(
//             doc.data()['username'],
//             doc.data()['description'],
//             doc.data()['image'],
//             doc.data()['phone'],
//             doc.data()['email'],
//             doc.data()['frindes'],
//             doc.data()['id']);
//       }).toList());
// }

finduserornot(num phone) {
  String y;
  FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      if (doc['phone'] == phone) {
        y = doc['id'];
      }
      print(y);
    });
  });
}

getallfrindes(String currentuserid) {
  List<String> frindesid = [];

  FirebaseFirestore.instance
      .collection('users')
      .doc(currentuserid)
      .collection('frindes')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      frindesid.add(doc['id']);
    });
    for (int i = 0; i < frindesid.length; i++) {
      print(frindesid[i]);
    }
  });

  return frindesid;
}
