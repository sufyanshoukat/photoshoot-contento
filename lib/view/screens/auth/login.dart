import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_fonts.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/view/widget/checkbox_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObsecureText = false;
  bool checkBoxStatus = false;
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoginAppBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  CustomTextField(
                    controller: authController.loginEmailController,
                    top: 39,
                    haveTitleText: true,
                    labelText: "Email",
                    hintText: "example@gmail.com",
                  ),
                  PasswordTextField(
                    controller: authController.loginPasswordController,
                    isObsecureText: isObsecureText,
                    onTap: () {
                      isObsecureText
                          ? isObsecureText = false
                          : isObsecureText = true;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      MyCheckBox(
                        isChecked: checkBoxStatus,
                        onChanged: (v) {
                          checkBoxStatus = v!;
                          authController.rememberMe.value = v;
                          setState(() {});
                        },
                      ),
                      MyText(
                        paddingLeft: 5,
                        text: "Remember me",
                        size: 12,
                        weight: FontWeight.w500,
                        color: kBlackColor,
                      ),
                      Spacer(),
                      MyText(
                        paddingLeft: 5,
                        text: "Forgot Password ?",
                        size: 12,
                        weight: FontWeight.w600,
                        color: kDarkBlueColor,
                        onTap: () {},
                      ),
                    ],
                  ),
                  Obx(() => authController.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: CircularProgressIndicator(),
                        )
                      : MyButton(
                          mTop: 32,
                          onTap: () {
                            authController.loginWithEmail();
                          },
                          buttonText: "Log In",
                          radius: 100,
                        )),
                  Align(
                    alignment: Alignment.center,
                    child: MyText(
                      paddingTop: 24,
                      paddingBottom: 16,
                      text: "Or login with",
                      size: 12,
                      weight: FontWeight.w500,
                      color: kBlackColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SocialButton(
                          icon: Assets.imagesGoogle,
                          text: "Google",
                          onTap: () {
                            authController.signInWithGoogle();
                          },
                        ),
                      ),
                      // SizedBox(width: 15),
                      // Expanded(
                      //   child: SocialButton(
                      //     icon: Assets.imagesApple,
                      //     text: "Apple",
                      //     onTap: () {},
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "By signing up, you agree to the ",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppFonts.Plus_Jakarta_Sans,
                  color: kBlackColor.withValues(alpha: 0.6),
                ),
                children: [
                  TextSpan(
                    text: "Terms of Service ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.Plus_Jakarta_Sans,
                      color: kBlackColor,
                    ),
                  ),
                  TextSpan(text: "and "),
                  TextSpan(
                    text: "Data Processing Agreement",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.Plus_Jakarta_Sans,
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
