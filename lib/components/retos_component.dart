import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/reto/registrar_reto_request.dart';
import 'package:surtus_app/api/responses/modulo/datos_modulo_response.dart';
import 'package:surtus_app/api/responses/reto/datos_reto_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/modulos.dart';
import 'package:surtus_app/api/services/reto.dart';
import 'package:surtus_app/components/evaluacion_reto_component.dart';
import 'package:surtus_app/components/principal_component.dart';
import 'package:surtus_app/shared/animacion/animated_constants.dart';
import 'package:surtus_app/shared/animated_menu.dart';
import 'package:surtus_app/shared/retos.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/popup_form.dart';
import 'package:surtus_app/widgets/text.dart';
import 'package:surtus_app/widgets/input.dart';

class RetosComponent extends StatefulWidget {
  RetosComponent({Key key}) : super(key: key);

  @override
  _RetosComponentState createState() => _RetosComponentState();
}

class _RetosComponentState extends State<RetosComponent> {
  ApiInscripcion inscripcion = ApiInscripcion();
  ApiReto apiReto = ApiReto();
  ApiModulos modulo = ApiModulos();
  String token;
  final reto = new RegistrarRetoRequest();
  List<DatosRetoResponse> retos = <DatosRetoResponse>[];

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

  crearReto(context) async {
    if (token != null) {
      final retoCreado = await apiReto.crearReto(reto.nombre, reto.idModulo, token, context);
      if (retoCreado != null) {
        setState(() {});
        Navigator.pop(context);
      }
    }
  }

  Widget _retosUsuario({double width}) {
    return FutureBuilder<List<DatosRetoResponse>>(
      future: apiReto.listarRetosUsuario(token),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: width,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                retos = snapshot.data;
                return RetosContainer(
                  key: UniqueKey(),
                  hasNavigation: retos[index].evaluacion.length > 0 ? false : true,
                  hasCircle: true,
                  nota: retos[index].evaluacion.length > 0
                      ? "Nota ${retos[index].evaluacion[0].nota}/5"
                      : 'Sin evaluar',
                  value: retos[index].nombre,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EvaluacionRetoComponent(
                          idReto: retos[index].id,
                          nombre: retos[index].nombre,
                          retoContext: context,
                          vieneDe: 'Reto',
                        ),
                      ),
                    ).then((value) => {
                      if (value == 'RetoExito') {
                        setState(() {})
                      }
                    });
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: tema.gray0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OwnIcon(
                      color: tema.gray8,
                      icon: SurtusIcon.back,
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: OwnText(
                        value: 'Retos',
                        fSize: 16.0,
                        fWeight: FontWeight.normal,
                      ),
                    ),
                    Spacer(),
                    OwnIcon(
                      color: tema.gray8,
                      icon: SurtusIcon.add,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return PopUpForm(
                              value: 'Crear retos',
                              isForm: true,
                              width: 296.0,
                              height: 180.0,
                              inputText: InputText(
                                  labelText: 'Nombre',
                                  labelColor: tema.mono5,
                                  hintText: 'Nombre',
                                  hintColor: tema.gray8,
                                  color: tema.gray8,
                                  colorBorder: tema.gray1,
                                  onChanged: (String nombre) =>
                                      reto.nombre = nombre),
                              inputSelect:
                                  FutureBuilder<List<DatosModuloResponse>>(
                                future: modulo.getModulos(token),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    List<String> modulos = [];
                                    for (int i = 0;
                                        i < snapshot.data.length;
                                        i++) {
                                      modulos.add(snapshot.data[i].nombre);
                                    }

                                    return Container(
                                      height: 58.0,
                                      child: DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: modulos,
                                        label: "Módulos",
                                        hint: "Seleccionar módulo",
                                        maxHeight: 120.0,
                                        showClearButton: false,
                                        dropDownButton: DropdownButton<String>(
                                          icon: Icon(SurtusIcon.right_arrow),
                                          iconSize: 24,
                                          style: TextStyle(
                                            color: tema.gray8,
                                          ),
                                          items: [],
                                        ),
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelStyle: TextStyle(
                                            color: tema.mono5,
                                            fontSize: 12.0,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFD1D3DB),
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: tema.gray3,
                                            ),
                                          ),
                                        ),
                                        onChanged: (String value) {
                                          for (var modulo in snapshot.data) {
                                            if (modulo.nombre == value) {
                                              reto.idModulo = modulo.id;
                                            }
                                          }
                                        },
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              onPressed: () => crearReto(context),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 36.0),
                Expanded(
                  child: _retosUsuario(
                    width: size.width,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
