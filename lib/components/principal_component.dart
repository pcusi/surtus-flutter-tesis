import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/reto/datos_reto_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/reto.dart';
import 'package:surtus_app/components/aprestamiento_component.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/components/perfil_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/menu.dart';
import 'package:surtus_app/shared/retos.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/modulos_container.dart';
import 'package:surtus_app/widgets/principal/interes_container.dart';
import 'package:surtus_app/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';

class PrincipalComponent extends StatefulWidget {
  PrincipalComponent({Key key}) : super(key: key);

  @override
  _PrincipalComponentState createState() => _PrincipalComponentState();
}

class _PrincipalComponentState extends State<PrincipalComponent> {
  ApiReto apiReto = ApiReto();
  ApiInscripcion apiInscripcion = ApiInscripcion();
  String token;
  List<DatosRetoResponse> retosEvaluados = [];

  obtenerToken() async {
    token = await apiInscripcion.getToken();
    setState(() {});
    return token;
  }

  @override
  void initState() {
    super.initState();
    obtenerToken();
    AnimatedConstants.xOffset = 0.0;
    AnimatedConstants.yOffset = 0.0;
    AnimatedConstants.scaleFactor = 1.0;
    AnimatedConstants.isDragged = false;
  }

  Widget _retosNoEvaluados({double height}) {
    return FutureBuilder<List<DatosRetoResponse>>(
      future: apiReto.listarRetosUsuario(token),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          retosEvaluados =
              snapshot.data.where((reto) => reto.estado == "E").toList();
          if (retosEvaluados.length == 0) {
            return SizedBox(
              height: 50.0,
              child: Center(
                child: OwnText(
                  value: 'No tengo ningún reto pendiente!',
                ),
              ),
            );
          } else {
            return SizedBox(
              height: height * .75,
              child: ListView.builder(
                itemCount: retosEvaluados.length,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return RetosContainer(
                    key: UniqueKey(),
                    hasNavigation: false,
                    hasCircle: true,
                    nota: "Nota ${retosEvaluados[index].evaluacion[0].nota}/5",
                    value: retosEvaluados[index].nombre,
                    onTap: () {},
                  );
                },
              ),
            );
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Material(
      child: Stack(
        children: [
          SurtusMenuDrawer(),
          MenuAnimatedContainer(
            xOffset: AnimatedConstants.xOffset,
            yOffset: AnimatedConstants.yOffset,
            scaleFactor: AnimatedConstants.scaleFactor,
            isDragged: AnimatedConstants.isDragged,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: tema.gray1,
                  borderRadius: AnimatedConstants.isDragged
                      ? BorderRadius.circular(25.0)
                      : BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MenuButton(
                              dragOn: () {
                                if (!AnimatedConstants.isDragged) {
                                  setState(() {
                                    AnimatedConstants.xOffset =
                                        size.width * 0.75;
                                    AnimatedConstants.yOffset =
                                        size.width * 0.20;
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
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 26.0),
                                  child: OwnIcon(
                                    color: tema.gray8,
                                    icon: SurtusIcon.user,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PerfilComponent(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 28.0),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    children: [
                                      OwnText(
                                        value: 'Te podría interesar',
                                        color: tema.mono7,
                                        fSize: 16.0,
                                        fWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  InteresContainer(
                                    width: size.width,
                                    height: 110.0,
                                    title: 'Guía de aprendizaje',
                                    subtitle: 'Ministerio de educación',
                                    bgColor: tema.mono5,
                                    navigateTo: () => launch(''),
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  InteresContainer(
                                    width: size.width,
                                    height: 110.0,
                                    title: 'Aprestamiento',
                                    subtitle: 'Primeros pasos',
                                    bgColor: tema.bgOne,
                                    navigateTo: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  AprestamientoComponent()));
                                    },
                                  ),
                                  SizedBox(
                                    height: 28.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OwnText(
                                        value: 'Módulos',
                                        color: tema.mono7,
                                        fSize: 16.0,
                                        fWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  SizedBox(
                                    height: size.height * .14,
                                    child: GridView.count(
                                      childAspectRatio: 2,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 16.0,
                                      mainAxisSpacing: 16.0,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.all(10.0),
                                      children: [
                                        ModulosContainer(
                                          width: 148.0,
                                          height: 64.0,
                                          bgColor: tema.gray1,
                                          value: 'Abecedario',
                                          image: 'assets/manos/abecedario.png',
                                          fColor: tema.gray8,
                                          fWeight: FontWeight.normal,
                                          fSize: 12.0,
                                          isRow: true,
                                        ),
                                        ModulosContainer(
                                          width: 148.0,
                                          height: 64.0,
                                          bgColor: tema.gray1,
                                          value: 'Abecedario',
                                          image: 'assets/manos/abecedario.png',
                                          fColor: tema.gray8,
                                          fWeight: FontWeight.normal,
                                          fSize: 12.0,
                                          isRow: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 28.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      OwnText(
                                        value: 'Reciente',
                                        color: tema.mono7,
                                        fSize: 16.0,
                                        fWeight: FontWeight.normal,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 26.0,
                                  ),
                                  _retosNoEvaluados(
                                    height: size.height,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
