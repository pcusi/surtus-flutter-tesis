import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/clase/clave_vista_request.dart';
import 'package:surtus_app/api/responses/clase/datos_clase_response.dart';
import 'package:surtus_app/api/services/clases.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class ClasesComponent extends StatefulWidget {
  final int idModulo;
  final String nombre;

  ClasesComponent({Key key, this.idModulo, this.nombre}) : super(key: key);

  @override
  _ClasesComponentState createState() => _ClasesComponentState();
}

class _ClasesComponentState extends State<ClasesComponent> {
  ApiClases apiClase = ApiClases();
  ApiInscripcion apiInscripcion = ApiInscripcion();
  Future _future;
  CarouselController claseController = CarouselController();
  CarouselSlider carouselSlider;
  int current = 0;

  Future<List<DatosClaseResponse>> obtenerClases() async {
    final initToken = await apiInscripcion.getToken();
    if (initToken != null) {
      final data = await apiClase.getClases(widget.idModulo, initToken);
      return data;
    }
    return null;
  }

  claseVista(int idClase) async {
    final initToken = await apiInscripcion.getToken();
    if (initToken != null) {
      ClaseVistaRequest request = ClaseVistaRequest();
      request.idClase = idClase;
      request.idModulo = widget.idModulo;
      await apiClase.claseVista(request, initToken);
    }
  }

  @override
  void initState() {
    super.initState();
    _future = obtenerClases();
  }

  Widget _claseCarousel({double w, double h, Color iColor}) {
    return FutureBuilder<List<DatosClaseResponse>>(
      future: _future,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final clasesWidget = snapshot.data.toList();
          return Container(
            width: w,
            height: h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OwnIcon(
                      color: iColor,
                      icon: SurtusIcon.back,
                      onTap: () => claseController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear),
                    ),
                    OwnText(
                      value: snapshot.data[current].nombre,
                    ),
                    Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: OwnIcon(
                        color: iColor,
                        icon: SurtusIcon.back,
                        onTap: () {
                          claseVista(snapshot.data[current].id);
                          claseController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 28.0),
                SizedBox(height: 56.0),
                carouselSlider = CarouselSlider(
                  carouselController: claseController,
                  items: clasesWidget.map((clase) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: w,
                          height: 200.0,
                          child: Image.network(
                            clase.imagen,
                          ),
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                      initialPage: 0,
                      height: 400.0,
                      viewportFraction: 1,
                      onPageChanged: (index, _) {
                        claseVista(snapshot.data[current].id);
                        setState(() {
                          current = index;
                        });
                      }),
                )
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Material(
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: double.maxFinite,
          decoration: BoxDecoration(color: tema.gray1),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      )
                    ],
                  ),
                  SizedBox(height: 48.0),
                  OwnText(
                    value: widget.nombre.toUpperCase(),
                    color: tema.gray8,
                    fWeight: FontWeight.normal,
                    fSize: 12.0,
                  ),
                  SizedBox(height: 24.0),
                  _claseCarousel(
                    w: size.width,
                    h: size.height * .9,
                    iColor: tema.gray8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
