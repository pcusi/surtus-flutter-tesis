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
  Future future;
  IniciarSesionRequest request = IniciarSesionRequest();
  Temas tema = Temas();
  bool isLoading = false;

  Future<String> obtenerToken() async {
    final _token = await apiInscripcion.getToken();
    return _token;
  }

  login() async {
    request.usuario = _usuarioController.text;
    request.clave = _claveController.text;

    setState(() {
      isLoading = true;
    });

    final isLogged = await apiInscripcion.login(request, context);

    if (isLogged) {
      setState(() {
        isLoading = false;
      });
      Future.delayed(Duration(seconds: 2), () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => PrincipalComponent()))
              .then((value) =>
                  {_usuarioController.clear(), _claveController.clear()}));
    }
  }

  @override
  void initState() {
    super.initState();
    future = obtenerToken();
  }

  Widget getComponentLogged({double width, double height}) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PrincipalComponent();
        }
        return SingleChildScrollView(
          child: Container(
            width: width,
            height: height,
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
        );
      },
    );
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
          ? SafeArea(
            child: InterceptorMessage(
                value: 'Estamos redireccionando a otra ventana',
              ),
          )
          : getComponentLogged(width: size.width, height: size.height),
    );
  }
}
