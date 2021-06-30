import 'package:flutter/material.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/requests/inscrito/iniciar_sesion_request.dart';
import 'package:surtus_app/components/principal_component.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/button.dart';
import 'package:surtus_app/widgets/input.dart';
import 'package:surtus_app/widgets/text.dart';

class LoginComponent extends StatefulWidget {
  LoginComponent({Key key}) : super(key: key);

  @override
  _LoginComponentState createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _usuarioController = TextEditingController();
  final _claveController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usuarioController.dispose();
    _claveController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();
    ApiInscripcion _api = ApiInscripcion();
    IniciarSesionRequest request = IniciarSesionRequest();


    login() async {

      request.usuario = _usuarioController.text;
      request.clave = _claveController.text;

      final isLogged = await _api.login(request, context);

      if (isLogged) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PrincipalComponent()))
            .then((value) => {
              _usuarioController.clear(),
              _claveController.clear()
            });
        }
    }

    return Material(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: tema.gray1),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 76.0),
                  OwnText(
                    value: 'Iniciar Sesión'.toUpperCase(),
                    color: tema.gray8,
                    fSize: 16.0,
                    fWeight: FontWeight.normal,
                  ),
                  SizedBox(height: 28.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/manos/login.png"),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.0),
                  InputText(
                    hintText: 'Usuario',
                    colorBorder: tema.gray3,
                    color: tema.gray8,
                    labelColor: tema.mono7,
                    controller: _usuarioController,
                  ),
                  SizedBox(height: 28.0),
                  InputText(
                    hintText: 'Contraseña',
                    isPassword: true,
                    colorBorder: tema.gray3,
                    color: tema.gray8,
                    labelColor: tema.mono7,
                    controller: _claveController,
                  ),
                  SizedBox(height: 32.0),
                  OwnButton(
                    btnBlock: true,
                    btnColor: tema.mono7,
                    value: 'Iniciar Sesión'.toUpperCase(),
                    pTop: 20.0,
                    pBottom: 20.0,
                    pLeft: 20.0,
                    pRight: 20.0,
                    fColor: Color(0xFFF9F9FA),
                    fWeight: FontWeight.normal,
                    fSize: 16.0,
                    onPressed: login,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
