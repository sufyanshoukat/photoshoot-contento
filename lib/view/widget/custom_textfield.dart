import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_fonts.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  final double radius;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;

  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color outlineBorderColor;
  final double outlineBorderWidth;
  final String hintText;
  final double hintTextFontSize;
  final Color hintTextFontColor;
  final bool filled;
  final Color backgroundColor;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingBottom;
  final double contentPaddingTop;
  final double left;
  final double right;
  final double top;
  final double bottom;

  final bool obscureText;
  final double iconScale;

  final bool havePrefixIcon;
  final bool haveSuffixIcon;

  final String? labelText;
  final bool haveTitleText;
  final Color lableColor;
  final Color txtColor;
  final bool enabled;
  final Widget? preffixWidget, suffixWidget;
  final GestureTapCallback? onSuffixTap;
  final VoidCallback? onTextFieldTap;
  final bool textFieldEnable, readOnly;
  final double height;
  final int maxLines;

  //final bool needSvgInPrefix;

  CustomTextField({
    super.key,
    this.controller,
    this.radius = 10,
    this.enabled = true,
    this.suffixWidget,
    this.preffixWidget,
    this.onSuffixTap,
    this.borderRadius = 0,
    this.borderColor = kWhiteColor,
    this.borderWidth = 0,
    this.focusedBorderColor = kSecondaryColor,
    this.focusedBorderWidth = 1,
    this.outlineBorderColor = kWhiteColor,
    this.outlineBorderWidth = 1,
    this.hintText = 'Hint here',
    this.hintTextFontColor = kGreyTextColor,
    this.hintTextFontSize = 12,
    this.filled = true,
    this.backgroundColor = kWhiteColor,
    this.contentPaddingLeft = 22,
    this.contentPaddingRight = 0,
    this.contentPaddingBottom = 0,
    this.contentPaddingTop = 0,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.haveSuffixIcon = false,
    this.obscureText = false,
    this.iconScale = 4,
    this.havePrefixIcon = false,
    this.labelText,
    this.haveTitleText = false,
    this.lableColor = kBlackColor,
    this.txtColor = kBlackColor,
    this.onTextFieldTap,
    this.textFieldEnable = true,
    this.readOnly = false,
    this.height = 45,
    this.maxLines = 1,
    //this.needSvgInPrefix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (haveTitleText == true)
              ? MyText(
                  paddingBottom: 7,
                  text: labelText ?? "lebel Text Here",
                  size: 12,
                  weight: FontWeight.w500,
                  color: lableColor,
                )
              : SizedBox(),
          Container(
            height: height,
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              obscureText: obscureText,
              readOnly: readOnly,
              enableInteractiveSelection: textFieldEnable,
              onTap: onTextFieldTap ?? null,
              cursorColor: kSecondaryColor,
              enabled: enabled,
              //onChanged: onChanged,
              style: TextStyle(color: txtColor, fontSize: 13),
              decoration: InputDecoration(
                prefixIcon: (havePrefixIcon == false)
                    ? null
                    : Container(
                        width: 40,
                        child: Center(child: preffixWidget),
                      ),
                suffixIcon: (haveSuffixIcon == false)
                    ? null
                    : InkWell(
                        onTap: onSuffixTap,
                        child: Container(child: suffixWidget),
                      ),
                filled: filled,
                fillColor: backgroundColor,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: hintTextFontColor,
                  fontSize: hintTextFontSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.Plus_Jakarta_Sans,
                  // AppFonts.SF_PRO_DISPLAY,
                ),
                border: outlineInputBorderDecoration(
                  r: borderRadius,
                  borderClr: borderColor,
                  width: borderRadius,
                ),
                focusedBorder: outlineInputBorderDecoration(
                  r: radius,
                  borderClr: focusedBorderColor,
                  width: focusedBorderWidth,
                ),
                enabledBorder: outlineInputBorderDecoration(
                  r: radius,
                  borderClr: outlineBorderColor,
                  width: outlineBorderWidth,
                ),
                disabledBorder: outlineInputBorderDecoration(
                  r: radius,
                  borderClr: outlineBorderColor,
                  width: outlineBorderWidth,
                ),
                contentPadding: EdgeInsets.only(
                  left: contentPaddingLeft,
                  bottom: contentPaddingBottom,
                  top: contentPaddingTop,
                  right: contentPaddingRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder outlineInputBorderDecoration({
    double? r,
    Color? borderClr,
    double? width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(r!),
      borderSide: BorderSide(color: borderClr!, width: width!),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  final bool isObsecureText;
  TextEditingController? controller;
  String? lebal, hint;
  VoidCallback? onTap;
  PasswordTextField({
    super.key,
    required this.isObsecureText,
    this.controller,
    this.hint,
    this.lebal,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      top: 16,
      controller: controller,
      obscureText: isObsecureText,
      haveTitleText: true,
      labelText: lebal ?? "Password",
      hintText: hint ?? "*******",
      onSuffixTap: onTap,
      haveSuffixIcon: true,
      suffixWidget: isObsecureText
          ? SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CommonImageView(
                  svgPath: Assets.imagesEyeCloseIcon,
                  height: 20,
                ),
              ),
            )
          : Icon(Icons.remove_red_eye, size: 20, color: kSecondaryColor),
    );
  }
}
