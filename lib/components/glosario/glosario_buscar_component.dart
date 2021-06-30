import 'dart:async';

import 'package:flutter/material.dart';
import 'package:surtus_app/api/responses/glosario/datos_glosario_response.dart';
import 'package:surtus_app/api/services/clases.dart';
import 'package:surtus_app/shared/retos.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class GlosarioBuscarComponent extends StatefulWidget {
  const GlosarioBuscarComponent({Key key}) : super(key: key);

  @override
  _GlosarioBuscarComponentState createState() =>
      _GlosarioBuscarComponentState();
}

class _GlosarioBuscarComponentState extends State<GlosarioBuscarComponent> {
  final _filtroController = TextEditingController(text: '');
  ApiClases apiClase = ApiClases();
  List<DatosGlosarioResponse> glosarios = <DatosGlosarioResponse>[];
  Timer debouncer;

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(milliseconds: 1000)}) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final glosarios = await apiClase.searchGlosario(_filtroController.text);
    setState(() => this.glosarios = glosarios);
  }

  Future filtrarGlosario(String filtro) async => debounce(() async {
        final glosarios = await apiClase.searchGlosario(filtro);

        if (!mounted) return;

        setState(() {
          filtro = this._filtroController.text;
          this.glosarios = glosarios;
        });
      });

  Widget _glosarioBuscado(DatosGlosarioResponse glosario) => RetosContainer(
        hasNavigation: false,
        hasCircle: false,
        nota: glosario.moduloNombre,
        value: glosario.nombre,
        onTap: () {},
      );

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
    _filtroController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          color: tema.gray1,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OwnIcon(
                      color: tema.gray8,
                      icon: SurtusIcon.back,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Container(
                        width: 240.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: tema.gray0,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFFF9F9FA),
                            width: 5.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(222, 225, 223, .25),
                              offset: Offset(0, 0),
                              blurRadius: 32.0,
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: TextField(
                              controller: _filtroController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.white30),
                              ),
                              style: TextStyle(
                                color: tema.gray8,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              onChanged: filtrarGlosario,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    OwnIcon(
                      color: tema.gray8,
                      icon: SurtusIcon.search,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 28.0,
                ),
                glosarios.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: glosarios.length,
                          itemBuilder: (_, index) {
                            final glosario = glosarios[index];
                            return _glosarioBuscado(glosario);
                          },
                        ),
                      )
                    : Center(
                        child: OwnText(
                          value: 'No se encontró información',
                          fSize: 16.0,
                          color: tema.gray8,
                          fWeight: FontWeight.w400,
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
