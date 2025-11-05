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

class MyBookingPage extends StatefulWidget {
  bool haveBackButton;
  MyBookingPage({super.key, this.haveBackButton = true});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(
              isBackButton: widget.haveBackButton,
              image: Assets.imagesMyBookingsAppBarLayout,
              title: 'My Bookings',
              subTitle: "View and manage your upcoming and past photoshoots.",
            ),
            SizedBox(height: 15),

            Container(
              height: 53,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xff969996),
              ),
              child: Row(
                children: List.generate(2, (index) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        height: 53,
                        decoration:
                            (selectedIndex == index) ? gradientShadow() : null,
                        child: Center(
                          child: MyText(
                            text: (index == 0) ? "Upcoming" : "Past",
                            weight: FontWeight.w500,
                            size: 16,
                            color: kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // --------- Upcoming Events -----------
            selectedIndex == 0
                ? Padding(
                  padding: AppSizes.HORIZONTAL,
                  child: Column(
                    children: List.generate(10, (index) {
                      return _EventCard(index: index);
                    }),
                  ),
                )
                : Padding(
                  padding: AppSizes.HORIZONTAL,
                  child: Column(
                    children: List.generate(10, (index) {
                      return _EventCard(index: index, isCompleted: true);
                    }),
                  ),
                ),

            SizedBox(height: 50),
          ],
        ),
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
      borderRadius: BorderRadius.circular(100),
    );
  }
}

class _EventCard extends StatelessWidget {
  int index;
  bool isCompleted;
  _EventCard({super.key, required this.index, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (index == 0) ? 12 : 10),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: AppStyling().gradientStyle1(),
      child: Row(
        children: [
          CommonImageView(
            height: 90,
            radius: 10,
            imagePath:
                (index.isEven)
                    ? Assets.imagesBeachPhoto
                    : Assets.imagesStudioPhoto,
          ),
          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 25,
                decoration: AppStyling().myDecoration(
                  borderColor: kTransperentColor,
                  color:
                      (isCompleted)
                          ? Color.fromARGB(255, 0, 133, 53)
                          : Color(0xffADD3BC),

                  radius: 5,
                ),
                child: Center(
                  child: MyText(
                    text: (isCompleted) ? "Completed" : "Confirmed",
                    size: 11,
                    weight: FontWeight.w700,
                    color: (isCompleted) ? kWhiteColor : Color(0xff008526),
                  ),
                ),
              ),

              MyText(
                paddingTop: 10,
                text: (index.isEven) ? "Sat, Oct 25, 2025" : "Book Photoshoot",
                size: 17,
                weight: FontWeight.w600,
                color: kWhiteColor,
              ),
              MyText(
                paddingBottom: 10,
                text:
                    (index.isEven)
                        ? "Indoor. Studio Lightning"
                        : "Indoor Lightning",
                size: 14,
                weight: FontWeight.w600,
                color: kWhiteColor.withValues(alpha: 0.5),
              ),

              SizedBox(
                width: 140,
                child: MyButton(
                  height: 33,
                  onTap: () {
                    Get.to(() => DateTimeSlot());
                  },
                  buttonText: "Cancel Booking",
                  gradient1: Color(0xffFF5574),
                  gradient2: Color(0xff993346),
                  fontColor: kWhiteColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
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
