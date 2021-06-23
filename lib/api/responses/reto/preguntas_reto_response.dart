import 'package:surtus_app/api/responses/reto/respuestas_reto_response.dart';

class PreguntasRetoResponse {
  String pregunta;
  String imagen;
  List<RespuestasResponse> respuestas;

  PreguntasRetoResponse({this.pregunta, this.imagen, this.respuestas});

  PreguntasRetoResponse.fromJson(Map<String, dynamic> json) {
    pregunta = json['pregunta'];
    imagen = json['imagen'];
    if (json['respuestas'] != null) {
      respuestas = <RespuestasResponse>[];
      json['respuestas'].forEach((v) {
        respuestas.add(new RespuestasResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pregunta'] = this.pregunta;
    data['imagen'] = this.imagen;
    if (this.respuestas != null) {
      data['respuestas'] = this.respuestas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
