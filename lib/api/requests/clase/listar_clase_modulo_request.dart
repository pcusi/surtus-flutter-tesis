class ListarClaseModuloRequest {
  int _idModulo = 0;

  int get idModulo => _idModulo;

  set idModulo(int idModulo) {
    if (idModulo != 0) {
      _idModulo = idModulo;
    }
  }

}