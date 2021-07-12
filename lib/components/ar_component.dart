import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class ArComponent extends StatefulWidget {
  const ArComponent({Key key}) : super(key: key);

  @override
  _ArComponentState createState() => _ArComponentState();
}

class _ArComponentState extends State<ArComponent> {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UnityWidgetController unityWidgetController;

  @override
  void initState() { 
    super.initState();
  }

  @override
  void dispose() { 
    unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Temas tema = Temas();
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  fullscreen: false,
                ),
              ),
              Positioned(
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: OwnIcon(
                      icon: SurtusIcon.back,
                      color: tema.gray0,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    width: 230.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: tema.gray0,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: OwnText(
                        value: 'Escanea el código de tu amigo.',
                        fSize: 14.0,
                        color: tema.gray8,
                        fWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      );
  }

  void onUnityCreated(controller) {
    this.unityWidgetController = controller;
  }
}
