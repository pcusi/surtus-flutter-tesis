import 'package:flutter/material.dart';

class OwnIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  const OwnIcon({
    Key key,
    this.icon,
    this.onTap,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(this.icon, color: this.color),
      onTap: this.onTap,
    );
  }
}
