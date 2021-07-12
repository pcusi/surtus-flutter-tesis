import 'package:flutter/material.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class GlosarioDetalleComponent extends StatefulWidget {
  final String moduloNombre;
  final String claseNombre;
  final String claseImagen;

  GlosarioDetalleComponent({
    Key key,
    @required this.moduloNombre,
    @required this.claseNombre,
    @required this.claseImagen,
  }) : super(key: key);

  @override
  _ClasesComponentState createState() => _ClasesComponentState();
}

class _ClasesComponentState extends State<GlosarioDetalleComponent> {

  Temas tema = Temas();

  @override
  void initState() {
    super.initState();
  }

  Widget glosarioDetalle() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OwnText(
                value: widget.claseNombre,
              ),
            ],
          ),
          SizedBox(height: 28.0),
          SizedBox(height: 56.0),
          Image.network(widget.claseImagen),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      child: Container(
        width: size.width,
        decoration: BoxDecoration(color: tema.gray1),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
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
                      value: 'Glosario',
                      fSize: 16.0,
                      fWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
              SizedBox(height: 48.0),
              OwnText(
                value: widget.moduloNombre.toUpperCase(),
                color: tema.gray8,
                fWeight: FontWeight.normal,
                fSize: 12.0,
              ),
              SizedBox(height: 24.0),
              glosarioDetalle(),
            ],
          ),
        ),
      ),
    );
  }
}
