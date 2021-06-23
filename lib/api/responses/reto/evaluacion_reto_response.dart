import 'package:surtus_app/api/responses/reto/preguntas_reto_response.dart';

class EvaluacionRetoResponse {
  List<PreguntasRetoResponse> evaluacion;

  EvaluacionRetoResponse([this.evaluacion]);

  EvaluacionRetoResponse.fromJson(dynamic json) {
    if (json['evaluacion'] != null) {
      evaluacion = <PreguntasRetoResponse>[];
      json['evaluacion'].forEach((v) {
        evaluacion.add(new PreguntasRetoResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.evaluacion != null) {
      data['evaluacion'] = this.evaluacion.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
