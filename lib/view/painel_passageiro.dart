import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uber/service/auth_service.dart';

class PainelPassageiro extends StatefulWidget {
  const PainelPassageiro({Key? key}) : super(key: key);

  @override
  _PainelPassageiroState createState() => _PainelPassageiroState();
}

class _PainelPassageiroState extends State<PainelPassageiro> {

  List<String> itensMenu = ["Configurações", "Deslogar"];
  final _auth = AuthService();

  Future<void> _selecionarMenu(String menu) async{
    if(menu == "Deslogar")
      await _auth.deslogarUsuario();
      Navigator.pushReplacementNamed(context, "/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Passageiro"),
        actions: [
          PopupMenuButton(onSelected: _selecionarMenu, itemBuilder: (context){
            return itensMenu.map((String item)
            {
              return PopupMenuItem(child: Text(item), value: item);
            }).toList();
          })
        ],
      ),
      body: Container(),
    );
  }
}
