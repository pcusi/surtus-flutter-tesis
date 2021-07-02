class GenerarEvaluacionRequest {

  int _idReto;
  int _idModulo;


  int get idReto => _idReto;
  int get idModulo => _idModulo;

  set idReto(int id) {
    if (id != 0) {
      _idReto = id;
    }
  }

  set idModulo(int id) {
    if (id != 0) {
      _idModulo = id;
    }
  }

}