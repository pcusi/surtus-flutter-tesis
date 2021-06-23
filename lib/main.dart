import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/components/login_component.dart';
import 'package:surtus_app/components/modulos_component.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/components/perfil_component.dart';
import 'package:surtus_app/components/principal_component.dart';
import 'package:surtus_app/components/retos_component.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/menu_hidden.dart';

import 'package:surtus_app/widgets/text.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class _MyAppState extends State<MyApp> {
  bool hasMenu = false;
  String token;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Temas tema = Temas();
    ApiInscripcion inscripcion = ApiInscripcion();

    Future<void> _getToken() async {
      final _token = await inscripcion.getToken();
      token = _token;
      return token;
    }

    Widget getComponentLogged() {
      return FutureBuilder(
        future: _getToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PrincipalComponent();
          }
          return LoginComponent();
        },
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SurtusMenuDrawer(),
            getComponentLogged(),
          ],
        )
      ),
    );
  }
}
