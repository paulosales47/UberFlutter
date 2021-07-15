import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber/view/home.dart';

void main(){

  final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xFF37474F),
    accentColor: Color(0XFF546E7A)
  );

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: temaPadrao,
  ));

}