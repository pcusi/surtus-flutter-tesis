import 'package:flutter/material.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/text.dart';

class AspectosWidget extends StatelessWidget {
  final double height;
  final double width;
  final Temas tema;
  final bool isAspecto;
  final Widget child;

  const AspectosWidget({
    Key key,
    this.width = 0.0,
    this.height = 0.0,
    this.tema,
    this.isAspecto = false,
    this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height * .18,
      child: isAspecto
          ? GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              mainAxisSpacing: 2,
              physics: NeverScrollableScrollPhysics(),
              children: [
                for (var i = 0; i < 2; i++)
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        OwnText(
                          value: i == 0
                              ? 'Aspectos Visuales'.toUpperCase()
                              : 'Aspectos Gestuales'.toUpperCase(),
                          color: tema.bgOne,
                          fSize: 12.0,
                          fWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Container(
                          width: width * .40,
                          height: height * .13,
                          decoration: BoxDecoration(
                            color: tema.gray1,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(-2, -2),
                                blurRadius: 4.0,
                                color: Colors.white,
                              ),
                              BoxShadow(
                                offset: Offset(2, 2),
                                blurRadius: 4.0,
                                color: Color(0xFF828282).withOpacity(.25),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OwnText(
                                  value: i == 0
                                      ? 'Atención Visual'
                                      : 'Expresión corporal',
                                  color: tema.gray8,
                                  fWeight: FontWeight.normal,
                                  fSize: 12.0,
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                OwnText(
                                  value: i == 0
                                      ? 'Discriminación Visual'
                                      : 'Expresión facial',
                                  color: tema.gray8,
                                  fWeight: FontWeight.normal,
                                  fSize: 12.0,
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                OwnText(
                                  value: i == 0 ? 'Memoria Visual' : 'Motricidad',
                                  color: tema.gray8,
                                  fWeight: FontWeight.normal,
                                  fSize: 12.0,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            )
          : this.child,
    );
  }
}
