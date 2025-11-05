import 'package:contento/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyling {
  BoxDecoration myDecoration({
    Color color = kQuaternaryColor,
    double radius = 10,
    Color borderColor = kQuaternaryColor,
    double thickness = 1,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: thickness),
    );
  }

  BoxDecoration allFourSideRaius({
    Color color = kPrimaryColor,
    double topLeft = 20,
    double topRight = 20,
    double bottomLeft = 0,
    double bottomRight = 0,
    Color borderColor = kTransperentColor,
    double thickness = 1,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft),
        topRight: Radius.circular(topRight),
        bottomLeft: Radius.circular(bottomLeft),
        bottomRight: Radius.circular(bottomRight),
      ),
      border: Border.all(color: borderColor, width: thickness),
    );
  }

  BoxDecoration myShadowDecoration({
    Color color = kSecondaryColor,
    double radius = 10,
    Color borderColor = kTransperentColor,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.1),
          spreadRadius: 0.2,
          blurRadius: 5,
        ),
      ],
    );
  }

  BoxDecoration bottomSheetStyle() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    );
  }

  BoxDecoration background({required String image}) {
    return BoxDecoration(
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
    );
  }

  BoxDecoration gradientStyle1({
    Color color1 = kTertiaryColor,
    Color color2 = kSecondaryColor,
  }) {
    return BoxDecoration(
      border: Border(
        top: BorderSide(color: kWhiteColor.withValues(alpha: 0.3), width: 2),
      ),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          color: kPrimaryColor.withOpacity(0.25),
          blurRadius: 15,
          spreadRadius: 0,
        ),
      ],
      gradient: LinearGradient(colors: [color1, color2]),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
