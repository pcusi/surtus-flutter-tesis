import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/components/login_component.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/components/principal_component.dart';

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
  String token;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

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
