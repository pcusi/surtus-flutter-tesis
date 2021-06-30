class DatosGlosarioResponse {
  int id;
  String nombre;
  String imagen;
  String moduloNombre;

  DatosGlosarioResponse({this.id, this.nombre, this.imagen, this.moduloNombre});

  factory DatosGlosarioResponse.fromJson(Map<String, dynamic> json) {
    return DatosGlosarioResponse(
        id: json['id'],
        nombre: json['nombre'],
        imagen: json['imagen'],
        moduloNombre: json['moduloNombre']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nombre": this.nombre,
      "imagen": this.imagen,
      "moduloNombre": this.moduloNombre
    };
  }

}