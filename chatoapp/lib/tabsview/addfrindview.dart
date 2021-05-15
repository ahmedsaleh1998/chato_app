import 'package:chato_app/models/usermodel.dart';
import 'package:chato_app/selectdata/add_n_f.dart';
import 'package:chato_app/w_and_h.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Add_friend extends StatefulWidget {
  @override
  _Add_friendState createState() => _Add_friendState();
}

class _Add_friendState extends State<Add_friend> {
  TextEditingController phonenumber = TextEditingController();
  num phone_number = 0;
  final _formKey_addfriend = GlobalKey<FormState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  String x;
  String x2;

  @override
  Widget build(BuildContext context) {
    var currentu = instance.currentUser.uid;
    getanothedata() async {}

    setanotherdata() async {
      var ff = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentu)
          .get();
      FirebaseFirestore.instance
          .collection('users')
          .doc(x2)
          .collection('frindes')
          .doc(currentu)
          .set({
        'username': ff['username'],
        'id': ff['id'],
        'email': ff['email'],
        'phone': ff['phone'],
        'image': ff['image'],
        'description': ff['description']
//             });
//           }
// ///////////////////////////////////////////////////part 2/////////

// /////////////////////////////////////////////////////////
//         });
      });
    }

    return Container(
      width: get_width(context),
      height: get_height(context),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: get_height(context) / 5,
                right: get_width(context) / 9,
                left: get_width(context) / 9),
            child: Form(
                key: _formKey_addfriend,
                child: Column(
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: phonenumber,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value == "") {
                            return 'this field is required';
                          }
                          return null;
                        }),

                    /////////////////////////////////
                    SizedBox(
                      width: get_width(context) / 4,
                      height: get_height(context) / 30,
                    ),
                    SizedBox(
                      width: get_width(context) / 2,
                      height: get_height(context) / 15,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey_addfriend.currentState.validate()) {
                            setState(() {
                              phone_number = int.parse(phonenumber.text);
                            });
                          }
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .get()
                                .then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                if (doc['phone'] == phone_number) {
                                  setState(() {
                                    x = doc['id'];
                                    x2 = x;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(instance.currentUser.uid)
                                      .collection('frindes')
                                      .doc(x)
                                      .set({
                                    'username': doc['username'],
                                    'id': doc['id'],
                                    'email': doc['email'],
                                    'phone': doc['phone'],
                                    'image': doc['image'],
                                    'description': doc['description'],
                                  });
                                }
                              });
                            });
                            setanotherdata();
                          } catch (e) {}
                        },
                        child: Text(
                          'Add New Friend',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Color.fromRGBO(55, 79, 71, 1.0),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
