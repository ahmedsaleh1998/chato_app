import 'dart:ui';

import 'package:chato_app/forgetpassword.dart';

import 'package:chato_app/hometabs.dart';
import 'package:chato_app/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chato_app/w_and_h.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  GlobalKey scafolindexkey = GlobalKey<ScaffoldState>();
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => hometabs()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    String e_mail = "";
    String pass_word = "";

    var padingright = (get_width(context) - get_width(context) / 1.1) / 2;

    void showsnackbaaar(context) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('you dont have account or pass and email are rong')));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'index',
      home: Scaffold(
        key: scafolindexkey,
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
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('Log in', style: TextStyle(fontSize: 30)),
                        ),
                        SizedBox(
                          width: get_width(context),
                          height: get_height(context) / 2.5,
                          child:
                              Image.asset("assets/login.png", fit: BoxFit.fill),
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
                        SizedBox(
                          width: get_width(context) / 4,
                          height: get_height(context) / 30,
                        ),
                        /////////////////////////////
                        TextFormField(
                            controller: password,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'password',
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

                        ///////////////////////////////
                        SizedBox(
                          width: get_width(context) / 4,
                          height: get_height(context) / 30,
                        ),
                        SizedBox(
                          width: get_width(context) / 1.1,
                          height: get_height(context) / 15,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: get_width(context) / 2,
                                height: get_height(context) / 15,
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        e_mail = email.text;
                                        pass_word = password.text;
                                      });
                                      try {
                                        await instance
                                            .signInWithEmailAndPassword(
                                                email: e_mail,
                                                password: pass_word);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    hometabs()));
                                      } catch (e) {
                                        showsnackbaaar(context);
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Log in',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Color.fromRGBO(55, 79, 71, 1.0),
                                ),
                              ),
                              SizedBox(
                                width: get_width(context) / 3,
                                height: get_height(context) / 15,
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Text('you alrady have account ? '),
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                forgetpass()));
                                  },
                                  child: Text('forget password',
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                            ],
                          ),
                        )
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
