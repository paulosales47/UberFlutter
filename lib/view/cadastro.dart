import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/usuario.dart';
import 'package:uber/service/auth_service.dart';
import 'package:uber/service/firestore_service.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  var _controllerNome = TextEditingController();
  var _controllerEmail = TextEditingController();
  var _controllerSenha = TextEditingController();
  bool _usuarioMotorista = false;
  String _mensagemErro = "";

  bool _validarCampos(){
    _mensagemErro = "";

    if(_controllerNome.text.isEmpty
    || _controllerEmail.text.isEmpty
    || !_controllerEmail.text.contains("@")
    || _controllerSenha.text.isEmpty
    || _controllerSenha.text.length < 8)
      setState(() {
        _mensagemErro = "Verifique se todos os campos foram preenchidos corretamente";
      });


    return _mensagemErro.length == 0;

  }

  Future<void> _cadastrarUsuario() async{
     if(_validarCampos()){
        var usuario = Usuario();
        usuario.nome = _controllerNome.text;
        usuario.email = _controllerEmail.text;
        usuario.senha = _controllerSenha.text;
        usuario.usuarioMotorista = _usuarioMotorista;

        var auth = AuthService();
        usuario.idUsuario = await auth.criarLoginUsuario(usuario);

        var firestore = FirestoreService();
        await firestore.cadastrarUsuario(usuario);

        if(_usuarioMotorista)
          Navigator.pushNamedAndRemoveUntil(context, "/motorista", (_) => false);
        else
          Navigator.pushNamedAndRemoveUntil(context, "/passageiro", (_) => false);
     }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  autofocus: true,
                  controller: _controllerNome,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                TextField(
                  obscureText: true,
                  controller: _controllerSenha,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha (8 caracteres mín)",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text("Passageiro"),
                      Switch(value: _usuarioMotorista, onChanged: (tipoUsuario) {
                        setState(() {
                          _usuarioMotorista = tipoUsuario;
                        });
                      }),
                      Text("Motorista")
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: ElevatedButton(
                    child: Text("Cadastrar", style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: _cadastrarUsuario,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0XFF1EBBD8)),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 16, 32, 16))
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: _mensagemErro.isNotEmpty
                        ? Text(_mensagemErro, style: TextStyle(color: Colors.red, fontSize: 16), textAlign: TextAlign.center)
                        : Container(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
