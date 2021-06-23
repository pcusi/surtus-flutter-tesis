import 'package:flutter/material.dart';
import 'package:surtus_app/widgets/text.dart';

class ModulosContainer extends StatelessWidget {
  final Color bgColor;
  final String value;
  final String image;
  final Color fColor;
  final double fSize;
  final double width;
  final double height;
  final FontWeight fWeight;
  final VoidCallback onTap;
  final bool isRow;

  const ModulosContainer(
      {Key key,
      this.bgColor,
      this.value,
      this.image,
      this.fColor,
      this.fSize,
      this.fWeight,
      this.onTap,
      this.width = 0.0,
      this.height = 0.0,
      this.isRow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: this.width,
        height: this.height,
        decoration: BoxDecoration(
          color: this.bgColor,
          boxShadow: [
            BoxShadow(
              color: Color(0XFFFFFFFF),
              blurRadius: 4.0,
              offset: Offset(-2, -2),
            ),
            BoxShadow(
              color: Color(0XFF828282).withOpacity(.25),
              blurRadius: 4.0,
              offset: Offset(2, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(isRow ? 16.0 : 25.0),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isRow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OwnText(
                        value: this.value.toUpperCase(),
                        color: this.fColor,
                        fSize: this.fSize,
                        fWeight: this.fWeight,
                      ),
                      Image(
                        image: AssetImage(this.image),
                        width: isRow ? 29.0 : 54.0,
                        height: isRow ? 46.0 : 87.0,
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        this.image,
                        width: 54.0,
                        height: 87.0,
                      ),
                      SizedBox(height: 11.0),
                      OwnText(
                        value: this.value.toUpperCase(),
                        color: this.fColor,
                        fSize: this.fSize,
                        fWeight: this.fWeight,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
