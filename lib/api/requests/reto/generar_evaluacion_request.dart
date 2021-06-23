class GenerarEvaluacionRequest {

  int _idReto;


  int get idReto => _idReto;

  set idReto(int id) {
    if (id != 0) {
      _idReto = id;
    }
  }

}