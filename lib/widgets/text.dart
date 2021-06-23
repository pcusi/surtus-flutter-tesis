import 'package:flutter/material.dart';
import 'package:surtus_app/shared/temas.dart';

class OwnText extends StatelessWidget {

  final double fSize;
  final Color color;
  final FontWeight fWeight;
  final double fHeight;
  final String value;
  final TextAlign fAlign;
  final bool isOverflow;
  final bool isGray;

  const OwnText({Key key,
  this.color,
  this.fSize,
  this.fWeight,
  this.fHeight,
  this.fAlign,
  this.isOverflow = false,
  this.isGray = false,
  this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Temas tema = Temas();

    return Text(
      this.value,
      textAlign: this.fAlign,
      overflow: isOverflow ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontFamily: 'Lato',
        fontSize: this.fSize,
        fontWeight: this.fWeight,
        height: this.fHeight,
        color: isGray ? tema.gray0 : this.color
      ),
    );
  }
}