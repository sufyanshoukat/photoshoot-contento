import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/screens/auth/sign_up.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/my_round_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 38, top: 70),
      width: Get.width,
      decoration: AppStyling().background(image: Assets.imagesAuthTopBk),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          CommonImageView(imagePath: Assets.imagesLogo2, height: 43),
          // Text
          MyText(
            paddingTop: 15,
            paddingBottom: 12,
            text: "Sign in to your\nAccount",
            size: 28,
            weight: FontWeight.w400,
            color: kWhiteColor,
          ),
          // Go To Sign Up
          Row(
            children: [
              MyText(
                text: "Don’t have an account? ",
                size: 12,
                weight: FontWeight.w500,
                color: kWhiteColor,
              ),
              MyText(
                paddingLeft: 5,
                text: "Sign Up",
                size: 12,
                weight: FontWeight.w600,
                color: kWhiteColor,
                onTap: () {
                  Get.to(() => SignUpPage());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RegisterAppBar extends StatelessWidget {
  const RegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 38, top: 70),
      width: Get.width,
      decoration: AppStyling().background(image: Assets.imagesRegisterAuthBk),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          MyRoundButton(
            onTap: () {
              Get.close(1);
            },
            child: CommonImageView(
              imagePath: Assets.imagesBackArrowIcon,
              height: 12,
            ),
          ),

          // Text
          MyText(
            paddingBottom: 12,
            text: "Register Your Account",
            size: 28,
            weight: FontWeight.w400,
            color: kWhiteColor,
          ),
          // Go To Sign Up
          Row(
            children: [
              MyText(
                text: "Already have an account? ",
                size: 12,
                weight: FontWeight.w500,
                color: kWhiteColor,
              ),
              MyText(
                paddingLeft: 5,
                text: "Sign in",
                size: 12,
                weight: FontWeight.w600,
                color: kWhiteColor,
                onTap: () {
                  Get.close(1);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Home

class HomeAppBar extends StatelessWidget {
  final String name;
  const HomeAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 38, top: 70),
      width: Get.width,
      decoration: AppStyling().background(image: Assets.imagesHomeAppBarLayout),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          CommonImageView(imagePath: Assets.imagesLogo2, height: 45),
          // Text
          MyText(
            paddingTop: 15,
            paddingBottom: 12,
            text: "Hi $name,",
            size: 28,
            weight: FontWeight.w400,
            color: kWhiteColor,
          ),
          // Welcome
          MyText(
            text: "Welcome back to your Photoshoot Plan!",
            size: 16,
            weight: FontWeight.w500,
            color: kWhiteColor,
          ),
        ],
      ),
    );
  }
}

// General App Bar

class GeneralAppBar extends StatelessWidget {
  final bool isBackButton;
  final String? title, subTitle;
  final String image;
  const GeneralAppBar({
    super.key,
    this.isBackButton = true,
    required this.image,
    this.subTitle,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 38, top: 70),
      width: Get.width,
      decoration: AppStyling().background(image: image),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          (isBackButton)
              ? MyRoundButton(
                  onTap: () {
                    Get.close(1);
                  },
                  child: CommonImageView(
                    imagePath: Assets.imagesBackArrowIcon,
                    height: 12,
                  ),
                )
              : SizedBox(height: 20, width: 20),

          // Text
          MyText(
            paddingBottom: (subTitle == null) ? 0 : 12,
            text: "$title",
            size: 28,
            weight: FontWeight.w400,
            color: kWhiteColor,
          ),
          // Go To Sign Up
          (subTitle == null)
              ? SizedBox.shrink()
              : MyText(
                  text: "$subTitle",
                  size: 15,
                  weight: FontWeight.w500,
                  color: kWhiteColor,
                ),
        ],
      ),
    );
  }
}
