import 'package:flutter/material.dart';

class OwnButton extends StatelessWidget {
  final bool btnBlock;
  final VoidCallback onPressed;
  final String value;
  final double pTop;
  final double pBottom;
  final double pLeft;
  final double pRight;
  final Color btnColor;
  final double fSize;
  final FontWeight fWeight;
  final double fHeight;
  final Color fColor;
  final bool hasShadow;

  const OwnButton({
    Key key,
    this.btnBlock = false,
    this.value,
    this.onPressed,
    this.pTop = 0.0,
    this.pBottom = 0.0,
    this.pLeft = 0.0,
    this.pRight = 0.0,
    this.btnColor,
    this.fSize,
    this.fWeight,
    this.fHeight,
    this.fColor,
    this.hasShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(btnColor),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: pTop,
          bottom: pBottom,
          left: pLeft,
          right: pRight,
        ),
        child: Container(
          width: btnBlock ? double.infinity : null,
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fSize,
              fontWeight: fWeight,
              height: fHeight,
              color: fColor,
            ),
          ),
        ),
      ),
    );
  }
}
