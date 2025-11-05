import 'package:contento/constants/app_colors.dart';
import 'package:flutter/material.dart';

class MyRoundButton extends StatelessWidget {
  final double height, width, splashRadius;
  final Color color, splashColor, borderColor;
  final VoidCallback onTap;
  final Widget child;
  final double borderStroke;
  final bool isShapeRound;

  const MyRoundButton({
    super.key,
    this.height = 36,
    this.width = 36,
    this.color = kTransperentColor,
    required this.onTap,
    required this.child,
    this.splashColor = kTertiaryColor,
    this.splashRadius = 36,
    this.borderColor = kTransperentColor,
    this.borderStroke = 1,
    this.isShapeRound = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: (isShapeRound) ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(color: borderColor, width: borderStroke),
        borderRadius: (isShapeRound) ? null : BorderRadius.circular(5),
      ),
      child: Material(
        color: kTransperentColor,
        child: InkWell(
          onTap: onTap,
          radius: splashRadius,
          splashColor: splashColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(50),
          child: Center(child: child),
        ),
      ),
    );
  }
}
