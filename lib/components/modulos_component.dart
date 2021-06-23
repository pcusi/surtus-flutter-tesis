import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/modulo/datos_modulo_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/modulos.dart';
import 'package:surtus_app/components/clases_component.dart';
import 'package:surtus_app/components/principal_component.dart';
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
  ApiModulos modulos = ApiModulos();
  ApiInscripcion inscripcion = ApiInscripcion();
  String token;
  bool showInput = false;

  obtenerToken() async {
    token = await inscripcion.getToken();
    setState(() {});
    return token;
  }

  @override
  void initState() {
    super.initState();
    obtenerToken();
  }

  Widget _gridModulos({Color bgColor, Color fColor}) {
    return FutureBuilder<List<DatosModuloResponse>>(
      future: modulos.getModulos(token),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClasesComponent(
                        idModulo: snapshot.data[i].id,
                        nombre: snapshot.data[i].nombre,
                      ),
                    ),
                  );
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

    return Material(
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              decoration: BoxDecoration(color: tema.gray1,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32.0, left: 32.0, right: 32.0,),
                    child: Row(
                      children: [
                        OwnIcon(
                          color: tema.gray8,
                          icon: SurtusIcon.back,
                          onTap: () {
                            Navigator.pop(context);
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
                        showInput
                            ? Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Container(
                            width: 165.0,
                            height: 22.0,
                            decoration: BoxDecoration(
                                color: tema.gray0,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(222, 225, 223, .25),
                                    offset: Offset(0, 0),
                                    blurRadius: 32.0,
                                  ),
                                ]),
                          ),
                        )
                            : Container(),
                        Spacer(),
                        OwnIcon(
                          color: tema.gray8,
                          icon: SurtusIcon.search,
                          onTap: () {
                            setState(() {
                              showInput = !showInput;
                            });
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
        ],
      ),
    );
  }
}
