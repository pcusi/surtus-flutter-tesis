import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/inscripcion/datos_inscrito_response.dart';
import 'package:surtus_app/components/login_component.dart';
import 'package:surtus_app/components/principal_component.dart';

import '../api.dart';

class ApiInscripcion {
  final storage = new FlutterSecureStorage();

  Future<bool> login(String usuario, String clave, BuildContext context) async {
    final _uri = "${Api.url}/${Api.inscripcion}/iniciarSesion";
    final response = await http.post(Uri.parse(_uri),
        body: {"usuario": usuario, "clave": clave},
        headers: {"Content-Type": "application/x-www-form-urlencoded"});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final token = await setToken(json["result"]["token"]);

      if (token != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PrincipalComponent()));
      }

      return true;
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      print(json);
    }

    return false;
  }

  setToken(String token) async {
    var tokenStr = await storage.write(key: Api.tokenName, value: token);
    tokenStr = token;
    return tokenStr;
  }

  Future<String> getToken() async {
    final _token = await storage.read(key: Api.tokenName);
    return _token;
  }

  Future<bool> cerrarSesion(context) async {
    await storage.delete(key: Api.tokenName);
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginComponent()));
    return true;
  }

  Future<DatosInscritoResponse> obtenerSesion(context) async {
    final _uri = "${Api.url}/${Api.inscripcion}/datos";
    final token = await getToken();
    final response = await http.get(Uri.parse(_uri), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      final inscrito = DatosInscritoResponse.fromJson(result);
      return inscrito;
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      print(json);
    }

    return null;
  }

}
