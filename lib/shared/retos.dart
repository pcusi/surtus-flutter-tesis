import 'package:flutter/material.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class RetosContainer extends StatelessWidget {
  final bool hasCircle;
  final bool hasNavigation;
  final Color color1;
  final Color color2;
  final Color iconColor;
  final String value;
  final String nota;
  final VoidCallback onTap;

  const RetosContainer({
    Key key,
    this.hasCircle = false,
    this.hasNavigation = false,
    this.color1,
    this.color2,
    this.iconColor,
    this.value,
    this.nota,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Temas tema = Temas();

    return Container(
      width: size.width,
      height: 75.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0,),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            tema.gray1,
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(40.0),
        boxShadow: [
          BoxShadow(
            color: Color(0XFFFFFFFF),
            blurRadius: 4.0,
            offset: Offset(-2, -2),
          ),
          BoxShadow(
            color: Color.fromRGBO(86, 86, 86, 0.25),
            blurRadius: 4.0,
            offset: -Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFFFFFFF),
                      blurRadius: 4.0,
                      offset: Offset(-2, -2),
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(86, 86, 86, 0.25),
                      blurRadius: 4.0,
                      offset: -Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: this.hasCircle
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            color: tema.mono7,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XFFFFFFFF),
                                blurRadius: 4.0,
                                offset: Offset(-2, -2),
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(86, 86, 86, 0.25),
                                blurRadius: 4.0,
                                offset: -Offset(2, 2),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OwnText(
                  value: this.value != null ? this.value : 'Reto 1',
                  fSize: 16.0,
                  color: this.color1,
                  isOverflow: true,
                ),
                SizedBox(height: 4.0,),
                OwnText(
                  value: this.nota,
                  fSize: 12.0,
                  color: Color(0xFF838383),
                )
              ],
            ),
            Spacer(),
            this.hasNavigation
                ? Expanded(
                    child: OwnIcon(
                      icon: SurtusIcon.right_arrow,
                      color: this.iconColor,
                      onTap: this.onTap,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
