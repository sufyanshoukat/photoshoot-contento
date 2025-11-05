import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(
              image: Assets.imagesAuthTopBk,
              title: 'Add Your Details',
              subTitle: 'Complete your profile details.',
            ),
            SizedBox(height: 11),

            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 107,
                    width: 107,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.imagesProfileDefaultImage),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 35,
                    child: CommonImageView(svgPath: Assets.imagesTrashIcon),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  // First & Last Name
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

                  // Email
                  CustomTextField(
                    top: 16,
                    haveTitleText: true,
                    labelText: "Email",
                    hintText: "Loisbecket@gmail.com",
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

                  MyButton(
                    mTop: 32,
                    onTap: () {},
                    radius: 10,
                    buttonText: "Confirm",
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
