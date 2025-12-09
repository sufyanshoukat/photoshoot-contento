import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/screens/location_selection/date_time_slot.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GeneralAppBar(
              isBackButton: false,
              image: Assets.imagesLocationScreenAppBarLayout,
              title: 'Choose Your Location',
              subTitle: "Select a photoshoot spot for this week",
            ),
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: List.generate(10, (index) {
                  return Container(
                    margin: EdgeInsets.only(top: (index == 0) ? 12 : 10),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                    decoration: AppStyling().gradientStyle1(),
                    child: Row(
                      children: [
                        CommonImageView(
                          height: 90,
                          radius: 10,
                          imagePath: (index.isEven)
                              ? Assets.imagesBeachPhoto
                              : Assets.imagesStudioPhoto,
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              text: (index.isEven)
                                  ? "Beachside Park"
                                  : "Book Photoshoot",
                              size: 18,
                              weight: FontWeight.w400,
                              color: kWhiteColor,
                            ),
                            MyText(
                              paddingBottom: 10,
                              text: (index.isEven)
                                  ? "Indoor. Studio Lightning"
                                  : "Indoor Lightning",
                              size: 14,
                              weight: FontWeight.w600,
                              color: kWhiteColor,
                            ),
                            SizedBox(
                              width: 140,
                              child: MyButton(
                                height: 33,
                                onTap: () {
                                  Get.to(() => DateTimeSlot());
                                },
                                buttonText: "Select",
                                gradient1: kWhiteColor,
                                gradient2: Color(0xff999999),
                                fontColor: kBlackColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
