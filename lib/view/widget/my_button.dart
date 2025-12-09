import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    required this.onTap,
    required this.buttonText,
    this.height = 48,
    this.backgroundColor = kSecondaryColor,
    this.fontColor = kPrimaryColor,
    this.fontSize = 16,
    this.outlineColor = kTransperentColor,
    this.radius = 100,
    this.svgIcon,
    this.svgIconColor,
    this.haveIcon = false,
    this.mBottom = 0,
    this.mTop = 0,
    this.iconSize,
    this.fontWeight = FontWeight.w700,
    this.gradient1 = kTertiaryColor,
    this.gradient2 = kSecondaryColor,
  });

  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double radius;
  final double fontSize;
  final Color outlineColor;
  final Color backgroundColor, fontColor;
  final Color? svgIconColor;
  final String? svgIcon;
  final bool haveIcon;
  final double? iconSize;
  final double mTop, mBottom;
  final FontWeight fontWeight;
  final Color gradient1, gradient2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: mTop, bottom: mBottom),
      height: height,
      decoration: BoxDecoration(
        // color: backgroundColor,
        // border: Border.all(color: outlineColor),
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
        gradient: LinearGradient(colors: [gradient1, gradient2]),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Material(
        color: kTransperentColor,
        child: InkWell(
          onTap: onTap,
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kTertiaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (haveIcon == true)
                  ? CommonImageView(
                      svgPath: svgIcon,
                      //svgIconColor: svgIconColor,
                      // height: iconSize,
                      width: iconSize,
                    )
                  : SizedBox(),
              MyText(
                paddingLeft: (haveIcon == true) ? 10 : 0,
                text: buttonText,
                size: fontSize,
                color: fontColor,
                weight: fontWeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String text, icon;
  final VoidCallback onTap;
  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: AppStyling().myDecoration(
        color: kWhiteColor,
        borderColor: kWhiteColor,
        radius: 12,
      ),
      child: Material(
        color: kTransperentColor,
        child: InkWell(
          onTap: onTap,
          splashColor: kSecondaryColor.withValues(alpha: 0.2),
          radius: 50,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonImageView(imagePath: icon, height: 18),
              MyText(
                paddingLeft: 10,
                text: text,
                size: 14,
                weight: FontWeight.w600,
                color: kBlackColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
