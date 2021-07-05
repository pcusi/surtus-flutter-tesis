import 'package:flutter/material.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/requests/inscrito/iniciar_sesion_request.dart';
import 'package:surtus_app/components/principal_component.dart';
import 'package:surtus_app/shared/interceptor.dart';
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
  ApiInscripcion apiInscripcion = ApiInscripcion();
  IniciarSesionRequest request = IniciarSesionRequest();
  Temas tema = Temas();
  bool isLoading = false;

  login() async {
    request.usuario = _usuarioController.text;
    request.clave = _claveController.text;

    setState(() {
      isLoading = true;
    });

    final isLogged = await apiInscripcion.login(request, context);

    if (isLogged) {
      Future.delayed(
          Duration(seconds: 2),
          () => {
                setState(() {
                  isLoading = false;
                }),
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (_) => PrincipalComponent()))
                    .then((value) =>
                        {_usuarioController.clear(), _claveController.clear()})
              });
    } else {
      setState(() {
        isLoading = false;
      });

      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        content: OwnText(
          fAlign: TextAlign.center,
          value: "Datos incorrectos!!",
          isGray: true,
          fSize: 16.0,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usuarioController.dispose();
    _claveController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? InterceptorMessage(value: 'Estamos redireccionando a otra ventana')
          : SingleChildScrollView(
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
