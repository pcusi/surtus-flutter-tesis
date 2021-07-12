import 'package:flutter/material.dart';
import 'package:surtus_app/components/ar_component.dart';
import 'package:surtus_app/components/glosario/glosario_component.dart';
import 'package:surtus_app/components/modulos_component.dart';
import 'package:surtus_app/components/principal_component.dart';
import 'package:surtus_app/components/qr_component.dart';
import 'package:surtus_app/components/retos_component.dart';
import 'package:surtus_app/shared/surtus_icon.dart';

class OpcionesMenu {
  String value;
  Widget child;
  IconData icon;

  OpcionesMenu({this.value, this.child, this.icon});

  static List<OpcionesMenu> opciones = [
    OpcionesMenu(
      value: "Principal",
      child: PrincipalComponent(),
      icon: SurtusIcon.home,
    ),
    OpcionesMenu(
      value: "Módulos",
      child: ModulosComponent(),
      icon: SurtusIcon.modules,
    ),
    OpcionesMenu(
      value: "Retos",
      child: RetosComponent(),
      icon: SurtusIcon.challenges
    ),
    OpcionesMenu(
      value: "Glosario",
      child: GlosarioComponent(),
      icon: SurtusIcon.glossary,
    ),
    OpcionesMenu(
      value: "QR",
      child: QrComponent(),
      icon: SurtusIcon.qr,
    ),
    OpcionesMenu(
      value: "AR",
      child: ArComponent(),
      icon: SurtusIcon.ar
    ),
  ];
}
