import 'package:flutter/material.dart';
import 'package:surtus_app/api/requests/reto/generar_evaluacion_request.dart';
import 'package:surtus_app/api/requests/reto/puntuar_evaluacion_request.dart';
import 'package:surtus_app/api/responses/reto/evaluacion_reto_response.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/api/services/reto.dart';
import 'package:surtus_app/components/retos_component.dart';
import 'package:surtus_app/shared/evaluacion/respuestas.dart';
import 'package:surtus_app/shared/interceptor.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/button.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/popup_form.dart';
import 'package:surtus_app/widgets/text.dart';

class EvaluacionRetoComponent extends StatefulWidget {
  final int idReto;
  final String nombre;
  final BuildContext retoContext;
  final String vieneDe;

  EvaluacionRetoComponent({
    Key key,
    @required this.idReto,
    @required this.nombre,
    this.retoContext,
    this.vieneDe,
  }) : super(key: key);

  @override
  _EvaluacionRetoComponentState createState() =>
      _EvaluacionRetoComponentState();
}

class _EvaluacionRetoComponentState extends State<EvaluacionRetoComponent> {
  ApiInscripcion apiInscripcion = ApiInscripcion();
  ApiReto apiReto = ApiReto();
  GenerarEvaluacionRequest request = GenerarEvaluacionRequest();
  PuntuarEvaluacionRequest puntuar = PuntuarEvaluacionRequest();
  PageController _evaluacionPageController = PageController(initialPage: 0);
  int currentPage = 0;
  Future _future;
  String _value;
  List<RespuestasCorrectas> respuestasCorrectas = [];
  String token;
  bool isLoading = false;
  IconData icon;
  int _lastIdSelected;
  String mensaje;

  Future<EvaluacionRetoResponse> getEvaluacionReto() async {
    final initToken = await apiInscripcion.getToken();
    token = initToken;
    request.idReto = widget.idReto;
    if (initToken != null) {
      final data =
          await apiReto.evaluacionInscritoReto(request.idReto, initToken);
      return data;
    }
    return null;
  }

  puntuarReto() {
    if (respuestasCorrectas.length == 0) {
      puntuar.nota = 0;
    } else {
      puntuar.nota = respuestasCorrectas.length;
    }

    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 5), () async {
      if (token != null) {
        final data = await apiReto.punturEvaluacionInscritoReto(
            request.idReto, puntuar.nota, token);
        if (data == "Evaluación puntuada") {
          setState(() {
            isLoading = false;
          });
          Navigator.of(context).pop(widget.vieneDe == 'Perfil' ? 'PerfilExito' : 'RetoExito');
          showDialog(
            context: widget.retoContext,
            builder: (context) {
              if (respuestasCorrectas.length == 5) {
                icon = SurtusIcon.smile;
                mensaje = "Excelente!";
              } else if (respuestasCorrectas.length == 4) {
                icon = SurtusIcon.happy;
                mensaje = "Casi perfecto!";
              } else if (respuestasCorrectas.length == 3) {
                icon = SurtusIcon.serious;
                mensaje = "Creo que podría mejorar!";
              } else if (respuestasCorrectas.length == 2) {
                icon = SurtusIcon.annoy;
                mensaje = "El próximo lo haré mejor!";
              } else if (respuestasCorrectas.length == 1) {
                icon = SurtusIcon.sad;
                mensaje = "Voy a estudiar mucho más!";
              } else {
                icon = SurtusIcon.cry;
                mensaje = "Ups!., Debo volver a intentarlo!";
              }

              return PopUpForm(
                value: widget.nombre,
                isForm: false,
                width: 296.0,
                height: 180.0,
                nota: respuestasCorrectas.length.toString(),
                icon: this.icon,
                mensaje: this.mensaje,
              );
            },
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _future = getEvaluacionReto();
  }

  @override
  void dispose() {
    super.dispose();
    _evaluacionPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? InterceptorMessage(
                value: 'Estamos evaluando tus respuestas',
              )
            : Padding(
                padding: const EdgeInsets.all(32.0),
                child: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(maxHeight: 750.0),
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: tema.gray0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                value: 'Retos',
                                fSize: 16.0,
                                fWeight: FontWeight.normal,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        SizedBox(height: 48.0),
                        OwnText(
                          value: widget.nombre.toUpperCase(),
                          fWeight: FontWeight.normal,
                          fSize: 12.0,
                          color: tema.gray8,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        _preguntaEvaluacion(
                          w: size.width,
                          purple: tema.mono7,
                          gray0: tema.gray0,
                          gray1: tema.gray1,
                          gray8: tema.gray8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  //parte de la evaluación
  Widget _preguntaEvaluacion(
      {double w, Color purple, Color gray1, Color gray0, Color gray8}) {
    return FutureBuilder<EvaluacionRetoResponse>(
      future: _future,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: w,
            height: 600.0,
            child: PageView.builder(
              onPageChanged: getChangedPageAndMoveBar,
              controller: _evaluacionPageController,
              itemCount: snapshot.data.evaluacion.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    width: w,
                    height: 420.0,
                    child: Column(
                      children: [
                        Container(
                          width: w,
                          height: 232.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            gradient: LinearGradient(
                              colors: [
                                gray0,
                                Color(0xFFFFFFFF),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XFFFFFFFF),
                                blurRadius: 4.0,
                                offset: Offset(-2, -2),
                              ),
                              BoxShadow(
                                color: Color(0xFF565656).withOpacity(0.25),
                                blurRadius: 4.0,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.network(
                                snapshot.data.evaluacion[index].imagen),
                          ),
                        ),
                        SizedBox(height: 36.0),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 150.0,
                          ),
                          child: GridView.builder(
                            itemCount: snapshot
                                .data.evaluacion[index].respuestas.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 3,
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, respuestaIndex) {
                              final respuestas =
                                  snapshot.data.evaluacion[index].respuestas;
                              return ListTile(
                                title: OwnText(
                                  value: respuestas[respuestaIndex].nombre,
                                  color: gray8,
                                  fAlign: TextAlign.right,
                                  fSize: 16.0,
                                ),
                                trailing: Radio(
                                  value: respuestas[respuestaIndex].nombre,
                                  groupValue: _value,
                                  activeColor: purple,
                                  hoverColor: purple,
                                  toggleable: true,
                                  onChanged: (String value) {
                                    setState(() {
                                      _value = value;
                                      if (_value ==
                                          snapshot.data.evaluacion[index]
                                              .pregunta) {
                                        _lastIdSelected =
                                            respuestas[respuestaIndex].id;
                                        respuestasCorrectas.add(
                                            RespuestasCorrectas(
                                                id: respuestas[respuestaIndex]
                                                    .id,
                                                esCorrecto:
                                                    respuestas[respuestaIndex]
                                                        .esCorrecto));
                                      } else {
                                        respuestasCorrectas.removeWhere(
                                            (respuesta) =>
                                                respuesta.id ==
                                                _lastIdSelected);
                                      }
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 3.0,
                              child: SizedBox(
                                width: 280.0,
                                height: 12.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  child: LinearProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(purple),
                                    backgroundColor: Color(0xFFD9E0FA),
                                    minHeight: 8.0,
                                    value: currentPage.toDouble(),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              child: OwnText(
                                value: "${(currentPage + 1)}/5",
                                fSize: 12.0,
                                color: gray8,
                                fWeight: FontWeight.normal,
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ],
                        ),
                        SizedBox(height: 44.0),
                        currentPage < 4
                            ? OwnButton(
                                value: 'Siguiente'.toUpperCase(),
                                btnBlock: true,
                                btnColor: gray1,
                                pTop: 20.0,
                                pBottom: 20.0,
                                hasShadow: true,
                                fColor: gray8,
                                fWeight: FontWeight.normal,
                                onPressed: () {
                                  _value = '';
                                  _lastIdSelected = 0;
                                  _evaluacionPageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              )
                            : OwnButton(
                                value: 'Aceptar'.toUpperCase(),
                                btnBlock: true,
                                btnColor: purple,
                                pTop: 20.0,
                                pBottom: 20.0,
                                fColor: gray0,
                                hasShadow: true,
                                onPressed: puntuarReto,
                              )
                      ],
                    ),
                  ),
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

  void getChangedPageAndMoveBar(int page) {
    currentPage = page;
    setState(() {});
  }
}
