class Usuario{

  String? _idUsuario;
  String? _nome;
  String? _email;
  String? _senha;
  bool? _usuarioMotorista;

  Map<String, dynamic> toMap(){
    Map<String, dynamic> mapUsuario = {
      "nome": this.nome,
      "email": this.email,
      "usuarioMotorista": this.usuarioMotorista
    };

    return mapUsuario;
  }

  Usuario();

  bool? get usuarioMotorista => _usuarioMotorista;

  set usuarioMotorista(bool? value) {
    _usuarioMotorista = value;
  }

  String? get senha => _senha;

  set senha(String? value) {
    _senha = value;
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
  }

  String? get nome => _nome;

  set nome(String? value) {
    _nome = value;
  }

  String? get idUsuario => _idUsuario;

  set idUsuario(String? value) {
    _idUsuario = value;
  }
}