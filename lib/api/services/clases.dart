import 'dart:convert';

import 'package:surtus_app/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:surtus_app/api/requests/clase/clave_vista_request.dart';
import 'package:surtus_app/api/responses/clase/datos_clase_response.dart';
import 'package:surtus_app/api/responses/glosario/datos_glosario_response.dart';

class ApiClases {
  Future<List<DatosClaseResponse>> getClases(int idModulo, String token) async {
    final Map<String, dynamic> body = {"idModulo": idModulo};
    final uri = "${Api.url}/${Api.clase}/listar";
    final response = await http.post(Uri.parse(uri),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      List<DatosClaseResponse> clases = List<DatosClaseResponse>.from(
          result.map((i) => DatosClaseResponse.fromJson(i)));
      return clases;
    } else {
      print("Ha pasado algo");
    }
    return [];
  }

  Future<List<DatosGlosarioResponse>> getGlosario() async {
    final uri = "${Api.url}/${Api.clase}/listarGlosario";
    final response = await http.get(
      Uri.parse(uri),
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      List<DatosGlosarioResponse> glosario = List<DatosGlosarioResponse>.from(
          result.map((i) => DatosGlosarioResponse.fromJson(i)));
      return glosario;
    } else {
      print("Ha pasado algo");
    }
    return [];
  }

  Future<List<DatosGlosarioResponse>> searchGlosario(String filtro) async {
    final uri = "${Api.url}/${Api.clase}/listarGlosario";
    final response = await http.get(
      Uri.parse(uri),
      headers: {"content-type": "application/json"},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      List<DatosGlosarioResponse> glosario = List<DatosGlosarioResponse>.from(
          result.map((i) => DatosGlosarioResponse.fromJson(i))).where((glosario)
      {
        final nombreLower = glosario.nombre.toLowerCase();

        return nombreLower.contains(filtro);

      }).toList();
      return glosario;
    } else {
      print("Ha pasado algo");
    }
    return [];
  }

  Future<bool> claseVista(ClaseVistaRequest request, token) async {
    Map<String, dynamic> body = {
      "idClase": request.idClase,
      "idModulo": request.idModulo
    };
    final uri = "${Api.url}/${Api.clase}/visto";
    final response = await http.post(Uri.parse(uri),
        body: jsonEncode(body),
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        });

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 203) {
      print("nada");
    }

    return false;
  }
}
