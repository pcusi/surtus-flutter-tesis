class DatosMarcadorInscritoResponse {
  String marcador;
  double nota;

  DatosMarcadorInscritoResponse({this.marcador, this.nota});

  factory DatosMarcadorInscritoResponse.fromJson(Map<String, dynamic> json) {
    return DatosMarcadorInscritoResponse(
      marcador: json['marcador'],
      nota: json['nota']
    );
  }

}