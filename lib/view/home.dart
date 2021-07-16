import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uber/model/usuario.dart';
import 'package:uber/service/auth_service.dart';
import 'package:uber/service/firestore_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  var _controllerEmail = TextEditingController();
  var _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  bool _carregando = false;

  bool _validarCampos(){
    _mensagemErro = "";

    if( _controllerEmail.text.isEmpty
        || !_controllerEmail.text.contains("@")
        || _controllerSenha.text.isEmpty
        || _controllerSenha.text.length < 8)
      setState(() {
        _mensagemErro = "Verifique se todos os campos foram preenchidos corretamente";
      });


    return _mensagemErro.length == 0;
  }

  Future<void> _logarUsuario() async{
    setState(() => _carregando = true);

    if(_validarCampos()){
      var usuario = Usuario();
      usuario.email = _controllerEmail.text;
      usuario.senha = _controllerSenha.text;

      var auth = AuthService();
      String idUsuario = await auth.logarUsuario(usuario);

      if(idUsuario == "ERRO"){
        _mensagemErro = "Ocorreu um erro ao realizar o login, tente novamente mais tarde";
        return;
      }

      await _redirecionarUsuarioPorTipo(idUsuario);
    }
  }

  Future<void> _redirecionarUsuarioPorTipo(String idUsuario) async{
    Usuario usuario = await _firestoreService.buscarUsuario(idUsuario);
    setState(() => _carregando = false);
    if(usuario.usuarioMotorista!)
      Navigator.pushNamedAndRemoveUntil(context, "/motorista", (route) => false);
    else
      Navigator.pushNamedAndRemoveUntil(context, "/passageiro", (route) => false);
  }

  Future<void> _verificaUsuarioLogado() async{
    String idUsuario = _authService.verificaUsuarioLogado();

    if(idUsuario.isNotEmpty)
      await _redirecionarUsuarioPorTipo(idUsuario);
  }

  @override
  void initState() {
    super.initState();
    _verificaUsuarioLogado();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/fundo.png'),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32), 
                  child: Image.asset('assets/image/logo.png', width: 200, height: 150)
                ),
                TextField(
                  autofocus: true,
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
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: ElevatedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: _logarUsuario,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0XFF1EBBD8)),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(32, 16, 32, 16))
                    ),
                  ),
                ),
                Center(
                  child: Center(
                    child: GestureDetector(
                      child: Text("Não tem conta? Cadastre-se!", style: TextStyle(color: Colors.white)),
                      onTap: (){
                        Navigator.pushNamed(context, "/cadastro");
                      },
                    ),
                  ),
                ),
                _carregando
                    ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white
                      ))
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text("Erro", style: TextStyle(color: Colors.red, fontSize: 16)),
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
