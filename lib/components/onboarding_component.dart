import 'package:flutter/material.dart';
import 'package:surtus_app/api/services/inscripcion.dart';
import 'package:surtus_app/components/login_component.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';
import 'dart:math' as math;

class OnboardingComponent extends StatefulWidget {
  const OnboardingComponent({Key key}) : super(key: key);

  @override
  _OnboardingComponentState createState() => _OnboardingComponentState();
}

class _OnboardingComponentState extends State<OnboardingComponent> {
  PageController _pageController = PageController(initialPage: 0);
  String assetName;
  String value;
  bool isMirror = false;
  bool lastPage = false;
  int currentPage = 0;
  double progressValue = 0.35;
  ApiInscripcion apiInscripcion = ApiInscripcion();
  String firstTime;
  Future _future;

  getFirstTime() async {
    firstTime = await apiInscripcion.getFirstTime();
    return firstTime;
  }

  @override
  void initState() {
    super.initState();
    _future = getFirstTime();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Temas tema = Temas();
    final size = MediaQuery.of(context).size;

    Widget _onBoarding() {
      return FutureBuilder(
        future: _future,
        builder: (_, snapshot) {
        if (snapshot.hasData) {
          return LoginComponent();
        } else {
          return PageView.builder(
            onPageChanged: onPageChanged,
            itemCount: 3,
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemBuilder: (_, index) {
              switch (index) {
                case 0:
                  if (index == 0) {
                    assetName = 'assets/manos/ob_1.png';
                    value =
                        'Podrás convertirte\n en un intérprete\n del lenguaje de\n señas, en poco\n tiempo.';
                    isMirror = false;
                    lastPage = false;
                  }
                  break;
                case 1:
                  if (index == 1) {
                    assetName = 'assets/manos/ob_2.png';
                    value =
                        'Sé parte de Surtus, y\n comienza a ser uno\n del millón de personas\n en Perú, que ayude a\n las persona sordas.';
                    isMirror = true;
                    lastPage = false;
                  }
                  break;
                case 2:
                  if (index == 2) {
                    assetName = 'assets/manos/ob_3.png';
                    value =
                        'Te enseñaremos a\n comunicarte en señas,\n en poco tiempo.';
                    isMirror = false;
                    lastPage = true;
                  }
                  break;
              }

              return Stack(
                children: [
                  lastPage
                      ? Positioned.fill(
                          bottom: size.width * .6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OwnText(
                                value: 'SURTUS',
                                fWeight: FontWeight.w600,
                                fSize: 36.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 26.0,
                              ),
                              OwnText(
                                value: value,
                                fWeight: FontWeight.w600,
                                fSize: 20.0,
                                color: Colors.white,
                                fAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : (isMirror
                          ? Positioned(
                              left: 0,
                              top: 0,
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Image(
                                  image: AssetImage(
                                      'assets/manos/vector_splash.png'),
                                ),
                              ),
                            )
                          : Positioned(
                              right: 0,
                              top: 0,
                              child: Image(
                                image: AssetImage(
                                    'assets/manos/vector_splash.png'),
                              ),
                            )),
                  isMirror
                      ? Positioned(
                          left: size.width * .12,
                          top: size.height * .12,
                          child: OwnText(
                            value: value,
                            color: lastPage ? tema.mono5 : tema.mono7,
                            fWeight: FontWeight.w600,
                            fSize: 20.0,
                            fAlign: TextAlign.left,
                          ),
                        )
                      : Positioned(
                          right: size.width * .12,
                          top: size.height * .12,
                          child: OwnText(
                            value: value,
                            color: lastPage ? tema.mono5 : tema.mono7,
                            fWeight: FontWeight.w600,
                            fSize: 20.0,
                            fAlign: TextAlign.right,
                          ),
                        ),
                  Positioned.fill(
                    bottom: size.height * .2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image(
                        image: AssetImage(assetName),
                        width: 184.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: size.width * .75,
                                  height: 8.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: LinearProgressIndicator(
                                      valueColor:
                                          AlwaysStoppedAnimation(tema.gray0),
                                      backgroundColor: tema.gray6,
                                      value: progressValue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: OwnIcon(
                                icon: SurtusIcon.avanzar_onbor,
                                color: tema.gray0,
                                onTap: () async {
                                  if (currentPage == 2) {
                                    await apiInscripcion.firstTime();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginComponent()));
                                  }

                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: tema.mono5,
          width: size.width,
          height: size.height,
          child: _onBoarding(),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    currentPage = page;
    progressValue = progressValue + 0.35;
    setState(() {});
  }
}
