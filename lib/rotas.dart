import 'package:flutter/material.dart';
import 'package:uber/view/cadastro.dart';
import 'package:uber/view/home.dart';
import 'package:uber/view/painel_motorista.dart';
import 'package:uber/view/painel_passageiro.dart';

class Rotas{
  
  static Route<dynamic> gerarRotas(RouteSettings settings){
    
    switch(settings.name){
      case "/" : return MaterialPageRoute(builder: (_) => Home());
      case "/cadastro" : return MaterialPageRoute(builder: (_) => Cadastro());
      case "/motorista" : return MaterialPageRoute(builder: (_) => PainelMotorista());
      case "/passageiro" : return MaterialPageRoute(builder: (_) => PainelPassageiro());
      default: return _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Text("Erro"),
        ),
        body: Center(
          child: Text("Tela não encontrda"),
        ),
      );
    });
  }
  
}