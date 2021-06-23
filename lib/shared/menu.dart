import 'package:flutter/material.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';

class MenuButton extends StatefulWidget {
  final VoidCallback dragOn;
  const MenuButton({Key key, this.dragOn}) : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  Temas tema = Temas();

  @override
  Widget build(BuildContext context) {
    return OwnIcon(
      icon: SurtusIcon.bars,
      color: tema.gray8,
      onTap: widget.dragOn,
    );
  }
}
