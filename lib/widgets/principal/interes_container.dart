import 'package:flutter/material.dart';
import 'package:surtus_app/shared/surtus_icon.dart';
import 'package:surtus_app/shared/temas.dart';
import 'package:surtus_app/widgets/icon.dart';
import 'package:surtus_app/widgets/text.dart';

class InteresContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color bgColor;
  final String title;
  final String subtitle;
  final VoidCallback navigateTo;
  const InteresContainer({
    Key key,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.bgColor,
    this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Temas tema = Temas();

    return Container(
      width: width,
      height: 110.0,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 30.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OwnText(
                    value: subtitle,
                    isOverflow: true,
                    color: tema.gray3,
                    fSize: 12.0,
                    fAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.0),
                  OwnText(
                    value: title,
                    color: Colors.white,
                    fSize: 16.0,
                  ),
                ],
              ),
            ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFFFFFFF).withOpacity(.15),
                      blurRadius: 3.0,
                      offset: Offset(-2, -2),
                      spreadRadius: 1.0),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .15),
                    blurRadius: 3.0,
                    offset: Offset(2, 2),
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: OwnIcon(
                icon: SurtusIcon.exercise,
                color: Colors.white,
                onTap: this.navigateTo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
