import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/inscrito/iniciar_sesion_request.dart';
import 'package:surtus_app/api/responses/inscripcion/parametros_inscrito_response.dart';

import '../api.dart';

class ApiInscripcion {
  final storage = new FlutterSecureStorage();

  Future<bool> login(IniciarSesionRequest request, BuildContext context) async {
    final _uri = "${Api.url}/${Api.inscripcion}/iniciarSesion";

    Map<String, dynamic> body = {"usuario": request.usuario, "clave": request.clave};

    final response = await http.post(Uri.parse(_uri),
        body: jsonEncode(body),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      await setToken(json["result"]["token"]);
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

  Future<bool> cerrarSesion() async {
    await storage.delete(key: Api.tokenName);
    return true;
  }

  Future<ParametrosInscritoResponse> obtenerSesion(context) async {
    final _uri = "${Api.url}/${Api.inscripcion}/datos";
    final token = await getToken();
    final response = await http.get(Uri.parse(_uri), headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json["result"];
      final inscrito = ParametrosInscritoResponse.fromJson(result);
      return inscrito;
    }

    return null;
  }
}
