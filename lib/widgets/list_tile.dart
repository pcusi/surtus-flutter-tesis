import 'package:flutter/material.dart';
import 'package:surtus_app/widgets/text.dart';

class OwnListTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final double fSize;
  final VoidCallback onTap;

  const OwnListTile({
    Key key,
    this.icon,
    this.color,
    this.value,
    this.fSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: GestureDetector(
            onTap: this.onTap,
            child: Row(
              children: [
                Icon(
                  this.icon,
                  color: this.color,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: OwnText(
                    fSize: this.fSize,
                    color: this.color,
                    value: this.value,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
