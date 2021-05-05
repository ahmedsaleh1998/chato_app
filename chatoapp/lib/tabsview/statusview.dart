import 'package:chato_app/w_and_h.dart';
import 'package:flutter/material.dart';

class Status_page extends StatefulWidget {
  @override
  _Status_pageState createState() => _Status_pageState();
}

class _Status_pageState extends State<Status_page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: get_width(context),
      height: get_height(context),
    );
  }
}
