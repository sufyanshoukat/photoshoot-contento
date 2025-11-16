import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/view/screens/membership/manage_membership.dart';
import 'package:contento/view/screens/settings/help.dart';
import 'package:contento/view/screens/settings/privacy_policy.dart';
import 'package:contento/view/screens/settings/terms_and_condition.dart';
import 'package:contento/view/screens/settings/update_password.dart';
import 'package:contento/view/screens/settings/update_profile.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthController authController = Get.find<AuthController>();

  List<ItemModel> items = [
    ItemModel(icon: Assets.imagesSA, title: "Change Password"),
    ItemModel(icon: Assets.imagesSB, title: "Manage Membership"),
    ItemModel(icon: Assets.imagesSC, title: "Terms & Conditions"),
    ItemModel(icon: Assets.imagesSD, title: "Privacy Policy"),
    ItemModel(icon: Assets.imagesSE, title: "Help Center"),
    ItemModel(icon: Assets.imagesSF, title: "Log Out"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(
              isBackButton: false,
              image: Assets.imagesAuthTopBk,
              title: 'Profile',
            ),
            SizedBox(height: 11),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => UpdateProfilePage());
                    },
                    child: Container(
                      height: 107,
                      width: 107,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.imagesProfileDefaultImage),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CommonImageView(svgPath: Assets.imagesEditImageIcon),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Obx(() => Align(
                  alignment: Alignment.center,
                  child: MyText(
                    text: authController.currentUser.value?.fullName ??
                        "Loading...",
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                )),
            Obx(() => Align(
                  alignment: Alignment.center,
                  child: MyText(
                    paddingTop: 2,
                    text: authController.currentUser.value?.email ?? "",
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                )),
            SizedBox(height: 17),
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Obx(() {
                // Filter out Change Password option for Google users
                List<ItemModel> filteredItems =
                    authController.currentUser.value?.authType == 'GOOGLE'
                        ? items
                            .where((item) => item.title != "Change Password")
                            .toList()
                        : items;

                return Column(
                  children: List.generate(filteredItems.length, (index) {
                    return SettingButton(
                      icon: filteredItems[index].icon,
                      title: filteredItems[index].title,
                      haveArrow: (filteredItems[index].title == "Log Out")
                          ? false
                          : true,
                      onTap: () {
                        // Adjust the switch statement based on the filtered list
                        String title = filteredItems[index].title;
                        switch (title) {
                          case "Change Password":
                            Get.to(() => UpdatePasswordPage());
                            break;
                          case "Manage Membership":
                            Get.to(() => ManageMemberShipPage());
                            break;
                          case "Terms & Conditions":
                            Get.to(() => TermsAndConditionPage());
                            break;
                          case "Privacy Policy":
                            Get.to(() => PrivacyPolicyPage());
                            break;
                          case "Help Center":
                            Get.to(() => HelpPage());
                            break;
                          default:
                            Get.bottomSheet(LogoutBSheet());
                            break;
                        }
                      },
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutBSheet extends StatelessWidget {
  const LogoutBSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Container(
      padding: AppSizes.DEFAULT,
      decoration: AppStyling().allFourSideRaius(
        color: Color(0xff323332),
        topLeft: 15,
        topRight: 15,
        bottomLeft: 0,
        bottomRight: 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyText(
            paddingBottom: 9,
            text: "Logout",
            size: 24,
            weight: FontWeight.w700,
            color: kWhiteColor,
          ),
          Container(height: 1, width: Get.width, color: kWhiteColor),
          MyText(
            paddingBottom: 50,
            paddingTop: 15,
            text: "Are you sure you want to log out?",
            size: 18,
            weight: FontWeight.w500,
            color: kWhiteColor,
          ),
          Row(
            children: [
              Expanded(
                child: MyButton(
                  onTap: () {
                    Get.back();
                  },
                  buttonText: "Cancel",
                  fontColor: Colors.red,
                  gradient1: kWhiteColor,
                  gradient2: kWhiteColor,
                  radius: 10,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: MyButton(
                  onTap: () {
                    authController.logout();
                  },
                  buttonText: "Yes, Logout",
                  fontColor: kWhiteColor,
                  gradient1: Colors.red,
                  gradient2: Colors.red,
                  radius: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
        ],
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
      child: InkWell(
        onTap: onTap,
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
      ),
    );
  }
}

class ItemModel {
  String title;
  String icon;

  ItemModel({required this.icon, required this.title});
}
