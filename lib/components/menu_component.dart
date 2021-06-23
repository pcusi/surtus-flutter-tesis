import 'package:flutter/material.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/menu_hidden.dart';

class SurtusMenuDrawer extends StatefulWidget {
  const SurtusMenuDrawer({Key key}) : super(key: key);

  @override
  _SurtusMenuDrawerState createState() => _SurtusMenuDrawerState();
}

class _SurtusMenuDrawerState extends State<SurtusMenuDrawer> {

  Temas tema = Temas();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tema.mono5,
      child: OwnMenuHidden(),
    );
  }
}
