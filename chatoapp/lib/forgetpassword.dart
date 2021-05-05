import 'dart:ui';

import 'package:chato_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chato_app/w_and_h.dart';

class forgetpass extends StatefulWidget {
  @override
  _forgetpassState createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final _formKeyforget = GlobalKey<FormState>();
  GlobalKey scafolgforget = GlobalKey<ScaffoldState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();

    String e_mail = "";

    var padingright = (get_width(context) - get_width(context) / 1.1) / 2;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'forgetpassword',
      home: Scaffold(
        key: scafolgforget,
        body: Container(
          width: get_width(context) / 1.1,
          height: get_height(context),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: padingright),
                child: Theme(
                  data: new ThemeData(
                    primaryColor: Color.fromRGBO(55, 79, 71, 1.0),
                    primaryColorDark: Colors.red,
                  ),
                  child: Form(
                    key: _formKeyforget,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('forget password',
                              style: TextStyle(fontSize: 30)),
                        ),
                        SizedBox(
                          width: get_width(context),
                          height: get_height(context) / 2.5,
                          child: Image.asset("assets/forget.png",
                              fit: BoxFit.fill),
                        ),
                        TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'E-mail',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty || value == "") {
                                return 'this field is required';
                              }
                              return null;
                            }),
                        ///////////////////////////////
                        SizedBox(
                          width: get_width(context) / 4,
                          height: get_height(context) / 30,
                        ),
                        SizedBox(
                          width: get_width(context) / 1.1,
                          height: get_height(context) / 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: get_width(context) / 2,
                                height: get_height(context) / 15,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKeyforget.currentState
                                        .validate()) {
                                      setState(() {
                                        e_mail = email.text;
                                      });
                                    }
                                    try {
                                      await instance.sendPasswordResetEmail(
                                          email: e_mail);
                                    } catch (e) {}
                                  },
                                  child: Text(
                                    'Reset Password',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Color.fromRGBO(55, 79, 71, 1.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
