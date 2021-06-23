import 'package:surtus_app/api/responses/reto/datos_evaluacion_response.dart';

class DatosRetoResponse {
  int id;
  String nombre;
  int idInscrito;
  int idModulo;
  String estado;
  List<DatosEvaluacionRetoResponse> evaluacion;

  DatosRetoResponse({
    this.id,
    this.nombre,
    this.idInscrito,
    this.idModulo,
    this.estado,
    this.evaluacion,
  });

  DatosRetoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    idInscrito = json['idInscrito'];
    idModulo = json['idModulo'];
    estado = json['estado'];
    if (json['evaluacion'] != null) {
      evaluacion = <DatosEvaluacionRetoResponse>[];
      json['evaluacion'].forEach((v) {
        evaluacion.add(new DatosEvaluacionRetoResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['idInscrito'] = this.idInscrito;
    data['idModulo'] = this.idModulo;
    data['estado'] = this.estado;
    if (this.evaluacion != null) {
      data['evaluacion'] = this.evaluacion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
