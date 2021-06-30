class DatosInscritoResponse {
  final String nombres;
  final String apellidos;
  final String usuario;
  final String nivel;

  DatosInscritoResponse({
    this.nombres,
    this.apellidos,
    this.usuario,
    this.nivel
  });

  factory DatosInscritoResponse.fromJson(Map<String, dynamic> json) {
    return DatosInscritoResponse(
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        usuario: json['usuario'],
        nivel: json['nivel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nombres": this.nombres,
      "apellidos": this.apellidos,
      "usuario": this.usuario,
      "nivel": this.nivel,
    };
  }
}
