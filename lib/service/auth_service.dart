import 'package:firebase_auth/firebase_auth.dart';
import 'package:uber/model/usuario.dart';

class AuthService{


  Future<String?> criarLoginUsuario(Usuario usuario) async{
    FirebaseAuth auth = FirebaseAuth.instance;

     UserCredential credential = await
     auth.createUserWithEmailAndPassword(
         email: usuario.email!,
         password: usuario.senha!
     );

     return credential.user!.uid;
  }

}