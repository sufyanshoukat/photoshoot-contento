import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/screens/membership/manage_membership.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberShipDetailPage extends StatefulWidget {
  const MemberShipDetailPage({super.key});

  @override
  State<MemberShipDetailPage> createState() => _MemberShipDetailPageState();
}

class _MemberShipDetailPageState extends State<MemberShipDetailPage> {
  List<ItemsModel> items = <ItemsModel>[
    ItemsModel(title: "Active", subTitle: 'Expries on 07-07-2026'),
    ItemsModel(title: "Credits Used ", subTitle: '2'),
    ItemsModel(title: "Credits Remaining", subTitle: '5'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            isBackButton: false,
            image: Assets.imagesMyBookingsAppBarLayout,
            title: 'Membership Details',
          ),
          SizedBox(height: 15),

          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 25),
            decoration: gradientShadow(),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ----- Premium Membership Card -------
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: AppStyling().myDecoration(
                        borderColor: kTransperentColor,
                        radius: 9,
                        color: kWhiteColor.withValues(alpha: 0.3),
                      ),
                      child: MyText(
                        text: "Premium Membership",
                        size: 15,
                        weight: FontWeight.w400,
                        color: kWhiteColor,
                      ),
                    ),

                    SizedBox(height: 9),

                    Column(
                      children: List.generate(items.length, (index) {
                        return InfoWidget(
                          title: items[index].title,
                          subTitle: items[index].subTitle,
                        );
                      }),
                    ),

                    SizedBox(height: 9),

                    Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: 159,
                        height: 41,
                        child: MyButton(
                          onTap: () {},
                          buttonText: "Renew Now",
                          fontColor: kWhiteColor,
                          gradient1: kWhiteColor.withValues(alpha: 0.1),
                          gradient2: kWhiteColor.withValues(alpha: 0.2),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MyButton(
              mTop: 23,
              onTap: () {
                Get.to(() => ManageMemberShipPage());
              },
              buttonText: "Manage Membership",
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration gradientShadow() {
    return BoxDecoration(
      border: Border(
        top: BorderSide(color: kWhiteColor.withValues(alpha: 0.3), width: 2),
      ),
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [Color(0xff323332), Color(0xff6C7278)],
      ),
      borderRadius: BorderRadius.circular(17),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title, subTitle;
  const InfoWidget({super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: title,
                weight: FontWeight.w500,
                size: 16,
                color: kWhiteColor,
              ),
              MyText(
                text: subTitle,
                weight: FontWeight.w600,
                size: 14,
                color: kWhiteColor.withValues(alpha: 0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemsModel {
  String title, subTitle;
  ItemsModel({required this.title, required this.subTitle});
}
