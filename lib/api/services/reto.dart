import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:surtus_app/api/responses/reto/datos_reto_response.dart';
import 'package:surtus_app/api/responses/reto/evaluacion_reto_response.dart';
//import 'package:surtus_app/api/responses/reto/evaluacion_reto_response.dart';
import 'package:surtus_app/api/services/modulos.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/text.dart';
import '../api.dart';

class ApiReto {
  Temas tema = Temas();
  ApiModulos apiModulos = ApiModulos();

  Future<String> crearReto(
      String nombre, int idModulo, String token, context) async {
    final Map<String, dynamic> body = {"nombre": nombre, "idModulo": idModulo};

    final uri = "${Api.url}/${Api.reto}/agregar";

    final response = await http.post(Uri.parse(uri),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        });

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        content: OwnText(
          fAlign: TextAlign.center,
          value: "Reto creado!!",
          isGray: true,
          fSize: 16.0,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return "Reto creado.";
    }

    return null;
  }

  Future<List<DatosRetoResponse>> listarRetosUsuario(String token) async {
    final uri = "${Api.url}/${Api.reto}/listar";

    final response = await http.get(Uri.parse(uri), headers: {
      "Authorization": "Bearer $token",
      "content-type": "application/json"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['result'];
      List<DatosRetoResponse> retos = List<DatosRetoResponse>.from(
          result.map((i) => DatosRetoResponse.fromJson(i)));
      return retos;
    }

    return null;
  }

  Future<EvaluacionRetoResponse> evaluacionInscritoReto(
      int idReto, int idModulo, String token) async {
    final uri = "${Api.url}/${Api.reto}/evaluacionReto";

    final Map<String, dynamic> body = {"idReto": idReto, "idModulo": idModulo};

    final response = await http.post(Uri.parse(uri),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['result'];
      final decode = EvaluacionRetoResponse.fromJson(result);
      return decode;
    }
    return null;
  }

  Future<String> punturEvaluacionInscritoReto(
      int idReto, int nota, String token) async {
    final uri = "${Api.url}/${Api.reto}/puntuarEvaluacion";

    final Map<String, dynamic> body = {"nota": nota, "idReto": idReto};

    final response = await http.post(
      Uri.parse(uri),
      body: jsonEncode(body),
      headers: {
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      },
    );
    
    if (response.statusCode == 200) {
      return "Evaluación puntuada";
    } else if (response.statusCode == 500) {
      return "No se creo la evaluación";
    }
    return "mal dato";
  }
}
