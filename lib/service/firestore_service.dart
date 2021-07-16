import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uber/model/usuario.dart';

class FirestoreService{

  Future<void> cadastrarUsuario(Usuario usuario) async{
    FirebaseFirestore _db  = FirebaseFirestore.instance;
    await _db
        .collection("usuario")
        .doc(usuario.idUsuario!)
        .set(usuario.toMap());
  }

  Future<Usuario> buscarUsuario(String idUsuario) async{
    FirebaseFirestore _db  = FirebaseFirestore.instance;
    DocumentSnapshot document = await _db.collection("usuario").doc(idUsuario).get();

    Usuario usuario = Usuario();
    usuario.idUsuario = idUsuario;
    usuario.nome = document.get("nome");
    usuario.email = document.get("email");
    usuario.usuarioMotorista = document.get("usuarioMotorista");
    return usuario;
  }

}
