import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:surtus_app/api/responses/inscripcion/datos_inscrito_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/shared/menu/opc_menu.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/list_tile.dart';
import 'package:surtus_app/widgets/text.dart';

class OwnMenuHidden extends StatefulWidget {
  OwnMenuHidden({Key key}) : super(key: key);

  @override
  _OwnMenuHiddenState createState() => _OwnMenuHiddenState();
}

class _OwnMenuHiddenState extends State<OwnMenuHidden> {
  Temas tema = Temas();
  ApiInscripcion inscripcion = ApiInscripcion();

  @override
  Widget _usuarioAutenticado() {
    return FutureBuilder<DatosInscritoResponse>(
      future: inscripcion.obtenerSesion(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OwnText(
                value: snapshot.data.nombres.toUpperCase(),
                fSize: 20.0,
                color: Color(0xFFF9F9F9),
              ),
              OwnText(
                value: snapshot.data.apellidos.toUpperCase(),
                fSize: 20.0,
                color: Color(0xFFF9F9F9),
              ),
              SizedBox(height: 12.0),
              OwnText(
                value: "Nivel ${snapshot.data.nivel}",
                fSize: 12.0,
                fWeight: FontWeight.w300,
                color: Color(0xFFF9F9F9),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        width: size.width,
        height: size.height,
        color: tema.mono7,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 64.0,
            vertical: 32.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 64.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tema.gray0,
                  ),
                ),
              ),
              _usuarioAutenticado(),
              SizedBox(height: 26.0),
              Container(
                width: 400.0,
                height: 300.0,
                child: ListView.builder(
                  itemCount: OpcionesMenu.opciones.length,
                  itemBuilder: (_, index) {
                    final opciones = OpcionesMenu.opciones;
                    return OwnListTile(
                      value: opciones[index].value,
                      icon: opciones[index].icon,
                      color: tema.gray0,
                      onTap: () => {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => opciones[index].child))
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              OwnListTile(
                value: 'Cerrar sesión',
                icon: SurtusIcon.logout,
                color: tema.gray0,
                fSize: 16.0,
                onTap: () async {
                  await inscripcion.cerrarSesion(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
