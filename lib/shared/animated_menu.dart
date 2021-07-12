import 'package:flutter/material.dart';

class MenuAnimatedContainer extends StatefulWidget {
  final Widget child;
  final double xOffset;
  final double yOffset;
  final double scaleFactor;
  final bool isDragged;

  const MenuAnimatedContainer({
    Key key,
    this.child,
    this.xOffset = 0.0,
    this.yOffset = 0.0,
    this.scaleFactor = 1.0,
    this.isDragged = false,
  }) : super(key: key);

  @override
  _MenuAnimatedContainerState createState() => _MenuAnimatedContainerState();
}

class _MenuAnimatedContainerState extends State<MenuAnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      transform: Matrix4.translationValues(widget.xOffset, widget.yOffset, 0)
        ..scale(widget.scaleFactor),
      child: widget.child,
    );
  }
}
