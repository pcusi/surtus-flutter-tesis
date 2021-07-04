import 'package:flutter/material.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/button.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class PopUpForm extends StatelessWidget {
  final bool isForm;
  final String value;
  final Widget inputText;
  final Widget inputSelect;
  final double width;
  final double height;
  final String nota;
  final IconData icon;
  final String mensaje;
  final VoidCallback onPressed;
  final VoidCallback onClose;

  const PopUpForm({
    Key key,
    this.isForm = false,
    this.value = '',
    this.inputText,
    this.inputSelect,
    this.onPressed,
    this.nota,
    this.width = 0.0,
    this.height = 0.0,
    this.icon,
    this.mensaje,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Temas tema = Temas();
    return AlertDialog(
      backgroundColor: tema.gray1,
      content: Container(
          width: isForm ? 296.0 : width,
          height: isForm ? 324.0 : height,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: isForm
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OwnText(
                          value: this.value,
                          color: tema.gray8,
                          fWeight: FontWeight.normal,
                          fSize: 20.0,
                        ),
                        OwnIcon(
                          icon: SurtusIcon.close,
                          color: tema.gray8,
                          onTap: onClose,
                        )
                      ],
                    ),
                    SizedBox(height: 40.0),
                    this.inputText,
                    SizedBox(height: 28.0),
                    this.inputSelect,
                    SizedBox(height: 32.0),
                    OwnButton(
                      value: 'Crear',
                      btnColor: tema.mono7,
                      fColor: tema.gray0,
                      fSize: 16.0,
                      fWeight: FontWeight.normal,
                      pTop: 20.0,
                      pBottom: 20.0,
                      btnBlock: true,
                      onPressed: this.onPressed,
                    )
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OwnText(
                          value: this.value,
                          color: tema.gray8,
                          fWeight: FontWeight.normal,
                          fSize: 16.0,
                        ),
                        OwnIcon(
                          icon: SurtusIcon.close,
                          color: tema.gray7,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.topLeft,
                      child: OwnText(
                        value: 'Puntaje:',
                        color: tema.gray7,
                        fWeight: FontWeight.normal,
                        fSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    OwnText(
                      value: "$nota/5",
                      color: tema.mono7,
                      fWeight: FontWeight.normal,
                      fSize: 48.0,
                    ),
                    SizedBox(height: 29.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OwnIcon(
                          icon: this.icon,
                          color: tema.mono7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: OwnText(
                            value: this.mensaje,
                            color: tema.gray7,
                            fWeight: FontWeight.normal,
                            fSize: 16.0,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
    );
  }
}
