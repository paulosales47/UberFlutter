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

  Future<String> logarUsuario(Usuario usuario) async{

    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential credential = await auth.signInWithEmailAndPassword(email: usuario.email!, password: usuario.senha!);

    return credential.user!.uid;
  }

  Future<void> deslogarUsuario() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  String verificaUsuarioLogado(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User? usuario = auth.currentUser;

    if(usuario != null)
      return usuario.uid;

    return "";
  }

}