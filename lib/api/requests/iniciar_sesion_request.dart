class IniciarSesionRequest {
  String _usuario = '';
  String _clave = '';

  String get usuario => _usuario;

  String get clave => _clave;

  set usuario(String usuario) {
    if (usuario != null) {
      _usuario = usuario;
    }
  }

  set clave(String clave) {
    if (clave != null) {
      _clave = clave;
    }
  }
}