class DatosModuloResponse {
  int id;
  String nombre;
  String imagen;
  String nivel;

  DatosModuloResponse({this.id, this.nombre, this.imagen, this.nivel});

  factory DatosModuloResponse.fromJson(Map<String, dynamic> json) {
    return DatosModuloResponse(
      id: json['id'],
      nombre: json['nombre'],
      imagen: json['imagen'],
      nivel: json['nivel']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nombre": this.nombre,
      "imagen": this.imagen,
      "nivel": this.nivel
    };
  }

  String moduloAsString() {
    return "${this.id} ${this.nombre}";
  }

}