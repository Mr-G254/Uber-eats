import 'package:flutter/material.dart';
import 'Logins/Login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: "Times"
    ),
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

