import 'package:covid19app/screens/homepage.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color.fromARGB(0xFF, 0xAA, 0x07, 0x6B),
          visualDensity: VisualDensity.comfortable,
          fontFamily: 'AnticSlab'),
      home:MyHomePage(),
    );
  }
}
