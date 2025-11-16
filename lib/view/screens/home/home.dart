import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => HomeAppBar(
                name: authController.currentUser.value?.fullName ?? "User",
              )),

          // ------
          Expanded(
            child: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                children: [
                  MemberShipCard(),

                  //------------------
                  Spacer(),
                  MyBtn(
                    isGradientStyle: true,
                    text: "Book Photoshoot",
                    icon: Assets.imagesHomeB,
                    onTap: () {},
                  ),
                  MyBtn(
                    text: "My Bookings",
                    icon: Assets.imagesHomeC,
                    onTap: () {},
                  ),
                  MyBtn(
                    text: "Membership Details",
                    icon: Assets.imagesHomeD,
                    onTap: () {},
                  ),

                  Spacer(flex: 2),

                  MyText(
                    paddingBottom: 20,
                    text: "Next credit renewal: Oct 30, 2025",
                    size: 15,
                    weight: FontWeight.w500,
                    color: kBlackColor,
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

class MyBtn extends StatelessWidget {
  final String text, icon;
  final bool isGradientStyle;
  final VoidCallback? onTap;
  const MyBtn({
    super.key,
    required this.text,
    required this.icon,
    this.isGradientStyle = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
      padding: EdgeInsets.only(left: 30, right: 20),
      height: 60,
      width: Get.width,
      decoration: (isGradientStyle)
          ? AppStyling().gradientStyle1()
          : AppStyling().myDecoration(
              borderColor: kTransperentColor,
              color: kBlackColor.withValues(alpha: 0.1),
            ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CommonImageView(svgPath: icon),
            MyText(
              paddingLeft: 10,
              text: text,
              size: 16,
              weight: FontWeight.w600,
              color: (isGradientStyle) ? kWhiteColor : kBlackColor,
            ),
          ],
        ),
      ),
    );
  }
}

class MemberShipCard extends StatelessWidget {
  const MemberShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      width: Get.width,
      decoration: AppStyling().gradientStyle1(),
      child: InkWell(
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonImageView(svgPath: Assets.imagesHomeA),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Monthly Membership",
                  size: 22,
                  weight: FontWeight.w400,
                  color: kWhiteColor,
                ),
                MyText(
                  text: "You have 2 credits left",
                  size: 14,
                  weight: FontWeight.w400,
                  color: kWhiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
