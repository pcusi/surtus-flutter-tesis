import 'dart:convert';

import 'package:surtus_app/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:surtus_app/api/responses/clase/datos_clase_response.dart';

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
}
