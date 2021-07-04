import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surtus_app/shared/aprestamiento/aprestamiento.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/aspectos.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class AprestamientoComponent extends StatefulWidget {
  AprestamientoComponent({Key key}) : super(key: key);

  @override
  _AprestamientoComponentState createState() => _AprestamientoComponentState();
}

class _AprestamientoComponentState extends State<AprestamientoComponent> {
  Temas tema = Temas();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size.width,
          constraints: BoxConstraints(
            maxHeight: double.maxFinite,
          ),
          color: tema.gray1,
          child: Padding(
            padding: EdgeInsets.only(left: 32.0, top: 32.0, right: 32.0),
            child: Column(
              children: [
                Row(
                  children: [
                    OwnIcon(
                      icon: SurtusIcon.back,
                      color: tema.gray8,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 32.0),
                      child: OwnText(
                        value: 'Aprestamiento',
                        color: tema.gray8,
                        fSize: 16.0,
                        fWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 48.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      height: size.height * 1.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          OwnText(
                            value: 'Aprestamiento para el aprendizaje'
                                .toUpperCase(),
                            color: tema.bgOne,
                            fSize: 12.0,
                            fWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 32.0),
                          Container(
                            width: size.width,
                            height: size.height * .186,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: tema.gray1,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.0,
                                  color: Color(0xFF565656).withOpacity(.25),
                                ),
                                BoxShadow(
                                  offset: Offset(-2, -2),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.0,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: OwnText(
                                value:
                                    'Aprender la lengua de señas es aprender otra lengua, con la diferencia de que para su emisión y recepción se utilizan canales diferentes a la audición y el habla articulada.\n\n Es un lenguaje que se percibe a través de la vista y requiere el uso de las manos como articuladores activos, el uso del espacio como lugar de articulación (estructura fonológica) y como referencia temporal.',
                                color: tema.gray8,
                                fSize: 12.0,
                                fWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          AspectosWidget(
                            width: size.width,
                            height: size.height,
                            tema: tema,
                            isAspecto: true,
                          ),
                          SizedBox(height: 40.0),
                          OwnText(
                            value:
                                'Ejercicios de atención y discriminación\n visual'
                                    .toUpperCase(),
                            color: tema.bgOne,
                            fSize: 12.0,
                            fWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          OwnText(
                            value:
                                'Identificar la diferencia entre las imágenes',
                            color: tema.gray8,
                            fSize: 12.0,
                            fWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: size.height * .8,
                            constraints: BoxConstraints(
                              maxHeight: double.infinity,
                            ),
                            child: AspectosWidget(
                              width: size.width,
                              height: size.height,
                              tema: tema,
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Aprestamiento.data.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 24.0,
                                  childAspectRatio: 1.2,
                                ),
                                itemBuilder: (_, index) {
                                  return Container(
                                    width: size.width,
                                    height: size.height * .25,
                                    margin: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      color: tema.gray1,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(-2, -2),
                                          blurRadius: 4.0,
                                          color: Colors.white,
                                        ),
                                        BoxShadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 4.0,
                                          color: Color(0xFF828282)
                                              .withOpacity(.25),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: size.width,
                                              height: size.height * .1,
                                              decoration: BoxDecoration(
                                                borderRadius:BorderRadius.circular(16.0),
                                                color: tema.gray1,
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(-2, -2),
                                                    blurRadius: 4.0,
                                                    color: Colors.white,
                                                  ),
                                                  BoxShadow(
                                                    offset: Offset(2, 2),
                                                    blurRadius: 4.0,
                                                    color: Color(0xFF828282)
                                                        .withOpacity(.25),
                                                  )
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 9.0, vertical: 21.0,),
                                                child: Image(
                                                  image: AssetImage(Aprestamiento.data[index].imagen),
                                                ),
                                              ),
                                            ),      
                                          ],
                                        ),
                                        SizedBox(height: 8.0,),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: OwnText(
                                              value: Aprestamiento
                                                  .data[index].nombre
                                                  .toUpperCase(),
                                              color: tema.mono6,
                                              fSize: 12.0,
                                              fWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
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
    );
  }
}
