import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/inscripcion/datos_marcador_inscrito_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/components/menu_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/menu.dart';
import 'package:surtus_app/shared/temas.dart';

class QrComponent extends StatefulWidget {
  QrComponent({Key key}) : super(key: key);

  @override
  _QrComponentState createState() => _QrComponentState();
}

class _QrComponentState extends State<QrComponent> {
  Temas tema = Temas();
  String token;
  ApiInscripcion apiInscripcion = ApiInscripcion();

  obtenerToken() async {
    token = await apiInscripcion.getToken();
    setState(() {});
    return token;
  }

  Widget obtenerMarcador({double width}) {
    return FutureBuilder<DatosMarcadorInscritoResponse>(
      future: apiInscripcion.obtenerMarcador(token),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: width,
            height: 350.0,
            child: Image.network(
              snapshot.data.marcador,
              fit: BoxFit.fill,
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SurtusMenuDrawer(),
          MenuAnimatedContainer(
            scaleFactor: AnimatedConstants.scaleFactor,
            xOffset: AnimatedConstants.xOffset,
            yOffset: AnimatedConstants.yOffset,
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
                      Align(
                        child: Row(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * .2,
                      ),
                      obtenerMarcador(
                        width: size.width,
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
