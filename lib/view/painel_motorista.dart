import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber/service/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PainelMotorista extends StatefulWidget {
  const PainelMotorista({Key? key}) : super(key: key);

  @override
  _PainelMotoristaState createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {

  List<String> itensMenu = ["Configurações", "Deslogar"];
  Completer<GoogleMapController> _controller = Completer();
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
        title: Text("Painel Motorista"),
        actions: [
          PopupMenuButton(onSelected: _selecionarMenu, itemBuilder: (context){
            return itensMenu.map((String item)
            {
              return PopupMenuItem(child: Text(item), value: item);
            }).toList();
          })
        ],
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(-23.194792656162665, -45.78458240266575),
            zoom: 16
          ),
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller){
            _controller = _controller;
          },
        ),
      ),
    );
  }
}
