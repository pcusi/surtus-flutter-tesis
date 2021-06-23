class DatosEvaluacionRetoResponse {
  int nota;
  String estado;

  DatosEvaluacionRetoResponse({
    this.nota,
    this.estado,
  });

  DatosEvaluacionRetoResponse.fromJson(Map<String, dynamic> json) {
    nota = json['nota'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nota'] = this.nota;
    data['estado'] = this.estado;
    return data;
  }

}
