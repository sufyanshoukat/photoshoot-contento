import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  bool isObsecureText1 = false;
  bool isObsecureText2 = false;
  bool isObsecureText3 = false;
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(
              image: Assets.imagesAuthTopBk,
              title: 'Change Password',
            ),
            SizedBox(height: 11),
            SizedBox(height: 16),
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  PasswordTextField(
                    controller: authController.oldPasswordController,
                    lebal: "Enter Old Password",
                    isObsecureText: isObsecureText1,
                    onTap: () {
                      isObsecureText1 = !isObsecureText1;
                      setState(() {});
                    },
                  ),
                  PasswordTextField(
                    controller: authController.newPasswordController,
                    lebal: "Enter New Password",
                    isObsecureText: isObsecureText2,
                    onTap: () {
                      isObsecureText2 = !isObsecureText2;
                      setState(() {});
                    },
                  ),
                  PasswordTextField(
                    controller: authController.confirmPasswordController,
                    lebal: "Confirm New Password",
                    isObsecureText: isObsecureText3,
                    onTap: () {
                      isObsecureText3 = !isObsecureText3;
                      setState(() {});
                    },
                  ),
                  Obx(() => authController.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: CircularProgressIndicator(),
                        )
                      : MyButton(
                          mTop: 32,
                          onTap: () {
                            authController.changePassword();
                          },
                          radius: 10,
                          buttonText: "Save",
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String title, icon;
  final bool haveArrow;
  final VoidCallback? onTap;
  final Color color;
  const SettingButton({
    super.key,
    this.haveArrow = true,
    required this.icon,
    required this.title,
    this.onTap,
    this.color = kWhiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 14),
      decoration: AppStyling().myDecoration(
        color: haveArrow ? color : Color(0xffDF1B28),
        borderColor: kTransperentColor,
      ),
      child: Row(
        children: [
          CommonImageView(svgPath: icon),
          Expanded(
            child: MyText(
              paddingLeft: 5,
              text: title,
              size: 14,
              weight: FontWeight.w500,
              color: haveArrow ? kBlackColor : kWhiteColor,
            ),
          ),
          Visibility(
            visible: haveArrow,
            child: Icon(
              Icons.arrow_forward_ios_outlined,
              color: kBlackColor.withValues(alpha: 0.5),
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemModel {
  String title;
  String icon;

  ItemModel({required this.icon, required this.title});
}
