import 'dart:ui';

import 'package:chato_app/forgetpassword.dart';
import 'package:chato_app/login.dart';
import 'package:flutter/material.dart';
import 'package:chato_app/w_and_h.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey_signup = GlobalKey<FormState>();
  GlobalKey scafoldsignupkey = GlobalKey<ScaffoldState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String e_mail = "";
    String pass_word = "";
    String user_name = "";
    num phone_number = 0;
    var padingright = (get_width(context) - get_width(context) / 1.1) / 2;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'index',
      home: Scaffold(
        key: scafoldsignupkey,
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
                    primaryColorDark: Colors.yellow,
                  ),
                  child: Form(
                    key: _formKey_signup,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('SignUp', style: TextStyle(fontSize: 30)),
                        ),
                        SizedBox(
                          width: get_width(context),
                          height: get_height(context) / 2.5,
                          child: Image.asset("assets/signup.png",
                              fit: BoxFit.fill),
                        ),
                        TextFormField(
                            controller: username,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: 'User name',
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
                            controller: email,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'E-mail',
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

                        //////////////////////////////////
                        SizedBox(
                          width: get_width(context) / 4,
                          height: get_height(context) / 30,
                        ),
                        /////////////////////////////
                        TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: phonenumber,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
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
                        ////////////////////////

                        ///////////////////////////////
                        SizedBox(
                          width: get_width(context) / 4,
                          height: get_height(context) / 25,
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
                                  onPressed: () {
                                    if (_formKey_signup.currentState
                                        .validate()) {
                                      setState(() {
                                        e_mail = email.text;
                                        pass_word = password.text;
                                        user_name = username.text;
                                        phone_number =
                                            int.parse(phonenumber.text);
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Sign Up',
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
                                            builder: (context) => Login()));
                                  },
                                  child: Text(
                                    'Login',
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
