import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber/rotas.dart';
import 'package:uber/view/home.dart';

void main() async{

  final ThemeData temaPadrao = ThemeData(
    primaryColor: Color(0xFF37474F),
    accentColor: Color(0XFF546E7A)
  );

  //Inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
    theme: temaPadrao,
    initialRoute: "/",
    onGenerateRoute: Rotas.gerarRotas,
  ));

}