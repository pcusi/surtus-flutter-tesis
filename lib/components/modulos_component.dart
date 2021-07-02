import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/modulo/registrar_inscritoModulo_request.dart';
import 'package:surtus_app/api/responses/modulo/datos_modulo_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/modulos.dart';
import 'package:surtus_app/components/clases_component.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/interceptor.dart';
import 'package:surtus_app/shared/menu.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/modulos_container.dart';
import 'package:surtus_app/widgets/text.dart';

class ModulosComponent extends StatefulWidget {
  ModulosComponent({Key key}) : super(key: key);

  @override
  _ModulosComponentState createState() => _ModulosComponentState();
}

class _ModulosComponentState extends State<ModulosComponent> {
  ApiModulos apiModulos = ApiModulos();
  ApiInscripcion inscripcion = ApiInscripcion();
  RegistrarInscritoModuloRequest request = RegistrarInscritoModuloRequest();
  String token;
  bool isFetching = false;
  bool showInput = false;

  obtenerToken() async {
    token = await inscripcion.getToken();
    setState(() {});
    return token;
  }

  inscritoModulo(int idModulo) async {
    request.idModulo = idModulo;
    await apiModulos.inscritoModulo(request, token);
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

  Widget _gridModulos({Color bgColor, Color fColor}) {
    return FutureBuilder<List<DatosModuloResponse>>(
      future: apiModulos.getModulos(token),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: snapshot.data.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemBuilder: (_, i) {
              return ModulosContainer(
                bgColor: bgColor,
                value: snapshot.data[i].nombre,
                image: snapshot.data[i].imagen,
                fColor: fColor,
                fSize: 12.0,
                onTap: () {
                  setState(() {
                    isFetching = true;
                  });

                  inscritoModulo(snapshot.data[i].id);

                  Future.delayed(
                      Duration(seconds: 2),
                      () => {
                            setState(() {
                              isFetching = false;
                            }),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ClasesComponent(
                                          idModulo: snapshot.data[i].id,
                                          nombre: snapshot.data[i].nombre,
                                        ))),
                          });
                },
              );
            },
          );
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
              child: isFetching
                  ? InterceptorMessage(
                value: 'Estamos cargando tus clases! Un momento.',
              )
                  : Container(
                decoration: BoxDecoration(
                  color: tema.gray1,
                  borderRadius: AnimatedConstants.isDragged
                      ? BorderRadius.circular(25.0)
                      : BorderRadius.circular(0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 32.0,
                        left: 32.0,
                        right: 32.0,
                      ),
                      child: Row(
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
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: OwnText(
                              value: 'Módulos',
                              fSize: 16.0,
                              fWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          OwnIcon(
                            color: tema.gray8,
                            icon: SurtusIcon.search,
                            onTap: () {
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(22.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 400,
                        ),
                        child: _gridModulos(
                          bgColor: tema.gray1,
                          fColor: tema.gray8,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
