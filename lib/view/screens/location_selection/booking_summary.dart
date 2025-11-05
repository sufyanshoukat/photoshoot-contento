import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSummaryPage extends StatefulWidget {
  BookingSummaryPage({super.key});

  @override
  State<BookingSummaryPage> createState() => _BookingSummaryPageState();
}

class _BookingSummaryPageState extends State<BookingSummaryPage> {
  List<ItemsModel> items = <ItemsModel>[
    ItemsModel(
      title: "Location",
      icon: Assets.imagesMarkerLocationIcon,
      subTitle: 'Downtown Studio',
    ),
    ItemsModel(
      title: "Date",
      icon: Assets.imagesCalenderDtViewIcon,
      subTitle: 'Satureday, Oct 25, 2025',
    ),
    ItemsModel(
      title: "Time",
      icon: Assets.imagesClockIcon,
      subTitle: '4:30 PM-5:30 PM',
    ),
    ItemsModel(
      title: "Credit Used",
      icon: Assets.imagesCreditIcon,
      subTitle: '1 Credit',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            isBackButton: true,
            image: Assets.imagesBookingSummaryAppBarLayout,
            title: 'Booking Summary',
            subTitle: "Review your photoshoot details before confirming.",
          ),
          SizedBox(height: 15),

          Container(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 27, vertical: 25),
            decoration: gradientShadow(),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length, (index) {
                return InfoWidget(
                  icon: items[index].icon,
                  title: items[index].title,
                  subTitle: items[index].subTitle,
                );
              }),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MyButton(
              mTop: 23,
              onTap: () {},
              buttonText: "Confirm Booking",
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
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          color: kPrimaryColor.withOpacity(0.25),
          blurRadius: 15,
          spreadRadius: 0,
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [kTertiaryColor, kSecondaryColor],
      ),
      borderRadius: BorderRadius.circular(17),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String icon, title, subTitle;
  const InfoWidget({
    super.key,
    required this.icon,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonImageView(svgPath: icon),
          SizedBox(width: 15),

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
  String title, subTitle, icon;
  ItemsModel({required this.title, required this.icon, required this.subTitle});
}
