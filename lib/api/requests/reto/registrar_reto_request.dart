class RegistrarRetoRequest {
  String _nombre = "";
  int _idModulo = 0;

  String get nombre => _nombre;
  int get idModulo => _idModulo;

  set nombre(String nombre) {
    if (nombre != null) {
      _nombre = nombre;
    }
  }

  set idModulo(int idModulo) {
    if (idModulo != null) {
      _idModulo = idModulo;
    }
  }
}
