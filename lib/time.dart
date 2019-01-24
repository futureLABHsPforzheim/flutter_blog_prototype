import 'package:flutter/material.dart';
import 'dart:async';

class Time extends StatefulWidget {
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  int hour = new DateTime.now().hour;
  int minute = new DateTime.now().minute;
  int second = new DateTime.now().second;

  @override
  Widget build(BuildContext context) {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) => getTime());

    return new Scaffold(
    body:  Center(
    child: new Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0,top:300),
      child: new Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
      children: [
        Text(
          "$hour",
          style: TextStyle(
          fontSize: 80,
        ),
        ),
        Text(
          '$minute',
          style: TextStyle(
          fontSize: 80,
        ),
        ),
        Text(
          '$second',
          style: TextStyle(
          fontSize: 80,
        ),
        ),
      ],
    ))));
  }

  

  getTime() {
    setState(() {
      print("getTime()");
      hour = new DateTime.now().hour;
      minute = new DateTime.now().minute;
      second = new DateTime.now().second;
    });
  }
}
