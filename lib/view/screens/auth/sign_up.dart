import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/view/screens/my_nav_bar/my_nav_bar.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isObsecureText = false;
  bool checkBoxStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegisterAppBar(),

          SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          haveTitleText: true,
                          labelText: "First Name",
                          hintText: "Lois",
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomTextField(
                          haveTitleText: true,
                          labelText: "Last Name",
                          hintText: "Becket",
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    top: 16,
                    haveTitleText: true,
                    labelText: "Email",
                    hintText: "example@gmail.com",
                  ),
                  CustomTextField(
                    top: 16,
                    haveTitleText: true,
                    labelText: "Birth of date",
                    hintText: "18/03/2024",
                    haveSuffixIcon: true,
                    suffixWidget: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: CommonImageView(
                          svgPath: Assets.imagesCalenderIcon,
                        ),
                      ),
                    ),
                  ),
                  CustomTextField(
                    top: 16,
                    haveTitleText: true,
                    labelText: "Phone Number",
                    hintText: "(454) 726-0592",
                    havePrefixIcon: true,
                    preffixWidget: SizedBox(
                      height: 50,
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonImageView(
                            imagePath: Assets.imagesFrance,
                            height: 20,
                          ),
                          SizedBox(width: 8),

                          Container(
                            height: 40,
                            width: .5,
                            color: kBlackColor.withValues(alpha: 0.3),
                          ),
                        ],
                      ),
                    ),
                  ),

                  PasswordTextField(
                    lebal: "Set Password",
                    isObsecureText: isObsecureText,
                    onTap: () {
                      isObsecureText
                          ? isObsecureText = false
                          : isObsecureText = true;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),

                  MyButton(
                    mTop: 32,
                    onTap: () {
                      Get.offAll(() => MyNavBar());
                    },
                    buttonText: "Sign Up",
                    radius: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
