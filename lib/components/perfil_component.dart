import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/inscrito/modulos_nivel_request.dart';
import 'package:surtus_app/api/responses/inscripcion/parametros_inscrito_response.dart';
import 'package:surtus_app/api/responses/reto/datos_reto_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/reto.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/components/retos_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/custom_paint/circle_progress.dart';
import 'package:surtus_app/shared/menu.dart';
import 'package:surtus_app/shared/retos.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/modulos_bloqueados.dart';
import 'package:surtus_app/widgets/text.dart';

import 'evaluacion_reto_component.dart';

class PerfilComponent extends StatefulWidget {
  PerfilComponent({Key key}) : super(key: key);

  @override
  _PerfilComponentState createState() => _PerfilComponentState();
}

class _PerfilComponentState extends State<PerfilComponent> {
  ApiInscripcion apiInscripcion = ApiInscripcion();
  ApiReto apiReto = ApiReto();
  ModulosNivelRequest request = ModulosNivelRequest();
  List<DatosRetoResponse> retosNoEvaluados = [];
  String token;
  String nivel;

  obtenerToken() async {
    token = await apiInscripcion.getToken();
    setState(() {});
    return token;
  }

  Widget _retosNoEvaluados({double width}) {
    return FutureBuilder<List<DatosRetoResponse>>(
      future: apiReto.listarRetosUsuario(token),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          retosNoEvaluados =
              snapshot.data.where((reto) => reto.estado == "N").toList();

          if (retosNoEvaluados.length == 0) {
            return Center(
              child: OwnText(
                value: 'No tengo ningún reto pendiente!',
              ),
            );
          } else {
            return Container(
              width: width,
              child: ListView.builder(
                itemCount: retosNoEvaluados.length,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return RetosContainer(
                    key: UniqueKey(),
                    hasNavigation: true,
                    hasCircle: true,
                    nota: 'Sin evaluar',
                    value: retosNoEvaluados[index].nombre,
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (_) => EvaluacionRetoComponent(
                            idReto: retosNoEvaluados[index].id,
                            nombre: retosNoEvaluados[index].nombre,
                            vieneDe: 'Perfil',
                          ),
                        ),
                      )
                          .then((value) => {
                        if (value == 'PerfilExito')
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RetosComponent(),
                              ),
                            )
                          }
                      });
                    },
                  );
                },
              ),
            );
          }
        }
        return Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _perfilAvance({Color circleOuterColor, double dpi, Color gray8}) {
    return FutureBuilder<ParametrosInscritoResponse>(
        future: apiInscripcion.obtenerSesion(context),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0XFFDFE0E6), Color(0XFFFFFFFF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0XFF565656).withOpacity(0.25),
                    blurRadius: 25.0,
                    spreadRadius: 5.0,
                    offset: Offset(2, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 25.0,
                    spreadRadius: 5.0,
                    offset: Offset(-5, -0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomPaint(
                  foregroundPainter: CircleProgress(
                    outer: circleOuterColor,
                    value: snapshot.data.avance.toDouble()
                  ),
                  child: Container(
                    width: dpi - 40,
                    height: dpi - 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OwnText(
                          value: 'Nivel: ${snapshot.data.inscrito.nivel}',
                          fSize: 12.0,
                          color: gray8,
                        ),
                        SizedBox(height: 8.0),
                        OwnText(
                        value: '${snapshot.data.avance}%',
                        fSize: 24.0,
                        fWeight: FontWeight.w300,
                          color: gray8,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    obtenerToken();
    AnimatedConstants.xOffset = 0;
    AnimatedConstants.yOffset = 0;
    AnimatedConstants.scaleFactor = 1.0;
    AnimatedConstants.isDragged = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();
    final dpi = 200.0;

    return Scaffold(
      body: Stack(
        children: [
          SurtusMenuDrawer(),
          MenuAnimatedContainer(
            xOffset: AnimatedConstants.xOffset,
            yOffset: AnimatedConstants.yOffset,
            scaleFactor: AnimatedConstants.scaleFactor,
            isDragged: AnimatedConstants.isDragged,
            child: SafeArea(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: tema.gray1,
                  borderRadius: AnimatedConstants.isDragged
                      ? BorderRadius.circular(25.0)
                      : BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuButton(
                            dragOn: () {
                              if (!AnimatedConstants.isDragged) {
                                setState(() {
                                  AnimatedConstants.xOffset = size.width * 0.75;
                                  AnimatedConstants.yOffset = size.width * 0.20;
                                  AnimatedConstants.scaleFactor = 0.80;
                                  AnimatedConstants.isDragged = true;
                                });
                              } else {
                                setState(() {
                                  AnimatedConstants.xOffset = 0.0;
                                  AnimatedConstants.yOffset = 0.0;
                                  AnimatedConstants.scaleFactor = 1.0;
                                  AnimatedConstants.isDragged = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      _perfilAvance(
                        circleOuterColor: tema.mono5,
                        gray8: tema.gray8,
                        dpi: dpi,
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ModuloBloqueado(
                            color1: tema.gray1,
                            color2: tema.gray2,
                            color3: tema.gray8,
                            iconColor: tema.gray8,
                            value: 'Básico',
                            isBlocked: false,
                          ),
                          ModuloBloqueado(
                            color1: tema.gray1,
                            color2: tema.gray2,
                            color3: tema.gray8,
                            value: 'Intermedio',
                            isBlocked: true,
                            iconColor: tema.gray8,
                          ),
                          ModuloBloqueado(
                            color1: tema.gray1,
                            color2: tema.gray2,
                            color3: tema.gray8,
                            value: 'Avanzado',
                            isBlocked: true,
                            iconColor: tema.gray8,
                          ),
                        ],
                      ),
                      SizedBox(height: 32.0),
                      Row(
                        children: [
                          OwnText(
                            value: 'Retos sin iniciar',
                            color: tema.mono7,
                            fSize: 16.0,
                            fWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      Expanded(
                        child: _retosNoEvaluados(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
