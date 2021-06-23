class DatosClaseResponse {
  int id;
  String nombre;
  String imagen;
  String video;
  int idModulo;

  DatosClaseResponse({this.id, this.nombre, this.imagen, this.video, this.idModulo});

  factory DatosClaseResponse.fromJson(Map<String, dynamic> json) {
    return DatosClaseResponse(
      id: json['id'],
      nombre: json['nombre'],
      imagen: json['imagen'],
      video: json['video'],
      idModulo: json['idModulo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "nombre": this.nombre,
      "imagen": this.imagen,
      "video": this.video,
      "idModulo": this.idModulo
    };
  }

}