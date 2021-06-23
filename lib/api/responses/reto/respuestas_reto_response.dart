class RespuestasResponse {
  int id;
  String nombre;
  bool esCorrecto;

  RespuestasResponse({this.id, this.nombre, this.esCorrecto = false});

  factory RespuestasResponse.fromJson(Map<String, dynamic> json) {
    return RespuestasResponse(
      id: json['id'],
      nombre: json['nombre'],
      esCorrecto: json['esCorrecto']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nombre": this.nombre,
      "esCorrecto": this.esCorrecto
    };
  }

}