import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surtus_app/widgets/text.dart';

class AlertApi extends StatelessWidget {
  final String mensaje;

  const AlertApi({Key key, this.mensaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              animating: true,
              radius: 16.0,
            ),
            SizedBox(height: 24.0),
            OwnText(
              value: mensaje,
              fSize: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
