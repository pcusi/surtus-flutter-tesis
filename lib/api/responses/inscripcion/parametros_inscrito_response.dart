import 'package:surtus_app/api/responses/inscripcion/datos_inscrito_response.dart';

class ParametrosInscritoResponse {
  ParametrosInscritoResponse({
    this.inscrito,
    this.avance,
  });

  DatosInscritoResponse inscrito;
  int avance;

  factory ParametrosInscritoResponse.fromJson(Map<String, dynamic> json)
  => ParametrosInscritoResponse(
    inscrito: DatosInscritoResponse.fromJson(json["inscrito"]),
    avance: json["avance"],
  );

  Map<String, dynamic> toJson() => {
    "inscrito": inscrito.toJson(),
    "avance": avance,
  };
}
