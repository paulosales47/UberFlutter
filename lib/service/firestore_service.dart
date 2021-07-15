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

}
