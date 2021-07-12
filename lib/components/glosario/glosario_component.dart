import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/glosario/datos_glosario_response.dart';
import 'package:surtus_app/api/services/clases.dart';
import 'package:surtus_app/components/glosario/glosario_buscar_component.dart';
import 'package:surtus_app/components/glosario/glosario_detalle_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/menu.dart';
import 'package:surtus_app/shared/retos.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

import '../menu_component.dart';

class GlosarioComponent extends StatefulWidget {
  const GlosarioComponent({Key key}) : super(key: key);

  @override
  _GlosarioComponentState createState() => _GlosarioComponentState();
}

class _GlosarioComponentState extends State<GlosarioComponent> {
  @override
  void initState() {
    super.initState();
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
    ApiClases apiClases = ApiClases();
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    Widget _glosario({double width}) {
      return FutureBuilder<List<DatosGlosarioResponse>>(
        future: apiClases.getGlosario(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: width,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return RetosContainer(
                    key: UniqueKey(),
                    hasNavigation: true,
                    hasCircle: false,
                    nota: snapshot.data[index].moduloNombre,
                    value: snapshot.data[index].nombre,
                    hasImage: true,
                    image: snapshot.data[index].imagen,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GlosarioDetalleComponent(
                            moduloNombre: snapshot.data[index].moduloNombre,
                            claseNombre: snapshot.data[index].nombre,
                            claseImagen: snapshot.data[index].imagen,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
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
                  padding:
                      const EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: OwnText(
                              value: 'Glosario',
                              fSize: 16.0,
                              fWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          OwnIcon(
                            color: tema.gray8,
                            icon: SurtusIcon.search,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GlosarioBuscarComponent(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28.0,
                      ),
                      Expanded(
                        child: _glosario(width: size.width),
                      )
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
