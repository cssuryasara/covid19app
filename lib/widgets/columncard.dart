// import 'package:covid19app/data/symptomdata.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

Column buildColumn(a) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        "${a.image}",
        height: 150,
      ),
      Text(
        "${a.name.toUpperCase()}",
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
