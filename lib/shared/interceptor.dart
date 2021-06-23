import 'package:flutter/material.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/text.dart';

class InterceptorMessage extends StatelessWidget {
  final String value;

  const InterceptorMessage({Key key, this.value,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Temas tema = Temas();

    return Material(
      child: Container(
        child: Center(
          child: OwnText(
            value: value,
            fSize: 16.0,
            fWeight: FontWeight.normal,
            color: tema.gray8,
          ),
        ),
      ),
    );
  }
}