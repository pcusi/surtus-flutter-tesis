import 'package:flutter/material.dart';
import 'package:surtus_app/shared/inner_shadow.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/widgets/text.dart';

class ModuloBloqueado extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final String value;
  final bool isBlocked;
  final Color iconColor;

  const ModuloBloqueado({
    Key key,
    this.color1,
    this.color2,
    this.color3,
    this.value = '',
    this.isBlocked = false,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          this.isBlocked
              ? InnerShadow(
                  blur: 4,
                  color: const Color(0XFF696C76).withOpacity(0.25),
                  offset: const Offset(2, 2),
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0XFFDFE0E6),
                          Color(0XFFFFFFFF),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        SurtusIcon.lock,
                        color: this.iconColor,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        this.color1,
                        this.color2,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.centerLeft,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: this.isBlocked
                        ? [
                            BoxShadow(
                              color: Color(0XFFFFFFFF),
                              blurRadius: 4.0,
                              offset: -Offset(-2, -2),
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(86, 86, 86, 0.25),
                              blurRadius: 4.0,
                              offset: -Offset(2, 2),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Color(0XFFFFFFFF),
                              blurRadius: 4.0,
                              offset: Offset(-2, -2),
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(86, 86, 86, 0.25),
                              blurRadius: 4.0,
                              offset: Offset(2, 2),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Icon(
                      SurtusIcon.lock_open,
                      color: this.iconColor,
                    ),
                  ),
                ),
          SizedBox(height: 16.0),
          OwnText(
            value: this.value,
            fSize: 12.0,
            color: this.color3,
          )
        ],
      ),
    );
  }
}
