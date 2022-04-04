// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ustasi_yapsin/screens//Karsilama2.dart';


void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Karsilama2())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 70, 20, 70),
        child: Container(

          decoration: BoxDecoration(
            color:Colors.white,
              image: DecorationImage(
                  image: AssetImage("assets/acılıs.png"),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
