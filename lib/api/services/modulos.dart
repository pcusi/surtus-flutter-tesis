import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:surtus_app/api/api.dart';
import 'package:surtus_app/api/requests/modulo/registrar_inscritoModulo_request.dart';
import 'package:surtus_app/api/responses/modulo/datos_modulo_response.dart';

class ApiModulos {
  Future<List<DatosModuloResponse>> getModulos(token) async {
    final uri = "${Api.url}/${Api.modulos}/listar";

    final response = await http
        .get(Uri.parse(uri), headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      List<DatosModuloResponse> modulos = List<DatosModuloResponse>.from(
          result.map((i) => DatosModuloResponse.fromJson(i)));
      return modulos;
    }
    return null;
  }


  Future<bool> inscritoModulo(RegistrarInscritoModuloRequest request, token) async {
    final uri = "${Api.url}/${Api.modulos}/inscritoModulo";

    Map<String, dynamic> body = {"idModulo": request.idModulo};

    final response = await http.post(Uri.parse(uri),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      return true;
    } else if(response.statusCode == 203) {
      print("pasaré al otro componente");
    }
    return false;
  }
}
