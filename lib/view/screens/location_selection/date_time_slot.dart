import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/screens/location_selection/booking_summary.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DateTimeSlot extends StatefulWidget {
  const DateTimeSlot({super.key});

  @override
  State<DateTimeSlot> createState() => _DateTimeSlotState();
}

class _DateTimeSlotState extends State<DateTimeSlot> {
  int selectedSlots = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            image: Assets.imagesTimeSlotAppBarLayout,
            title: 'Select Date & Time',
            subTitle: "Choose an available date and time for your photoshoot.",
          ),

          SizedBox(height: 32),
          WeekdaySelector(),
          SizedBox(height: 32),
          MyText(
            paddingBottom: 10,
            paddingLeft: 20,
            text: "Available time Slots:",
            size: 22,
            weight: FontWeight.w500,
          ),

          // Avaliblilty Time selector
          Wrap(
            children: List.generate(5, (index) {
              List<String> slots = [
                '10:00 AM',
                '11:00 AM',
                '2:00 PM',
                "3:00 PM",
                "5:00 PM",
              ];
              return InkWell(
                onTap: () {
                  selectedSlots = index;
                  setState(() {});
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration:
                      selectedSlots == index
                          ? BoxDecoration(
                            // color: backgroundColor,
                            // border: Border.all(color: outlineColor),
                            border: Border(
                              top: BorderSide(
                                color: kWhiteColor.withValues(alpha: 0.3),
                                width: 2,
                              ),
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
                              colors: [kTertiaryColor, kSecondaryColor],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          )
                          : AppStyling().myDecoration(
                            borderColor: kSecondaryColor.withValues(alpha: 0.3),
                            color: kTransperentColor,
                          ),
                  child: MyText(
                    text: slots[index],
                    weight: FontWeight.w400,
                    size: 15,
                    color: selectedSlots == index ? kWhiteColor : kBlackColor,
                  ),
                ),
              );
            }),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MyButton(
              mTop: 64,
              onTap: () {
                Get.to(() => BookingSummaryPage());
              },
              buttonText: "Continue",
            ),
          ),
        ],
      ),
    );
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final VoidCallback onTap;

  const DayTile({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient:
              isSelected
                  ? const LinearGradient(
                    colors: [Colors.grey, Colors.black54],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color: isSelected ? null : Colors.grey.shade300,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyText(
              text: day,
              weight: FontWeight.w400,
              size: 18,
              color: isSelected ? kWhiteColor : kBlackColor,
            ),
            const SizedBox(height: 4),
            MyText(
              text: date,
              weight: FontWeight.w400,
              size: 18,
              color: isSelected ? kWhiteColor : kBlackColor,
            ),
            // Text(
            //   date,
            //   style: GoogleFonts.poppins(
            //     fontSize: 15,
            //     fontWeight: FontWeight.w500,
            //     color: isSelected ? Colors.white : Colors.black87,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class WeekdaySelector extends StatefulWidget {
  const WeekdaySelector({super.key});

  @override
  State<WeekdaySelector> createState() => _WeekdaySelectorState();
}

class _WeekdaySelectorState extends State<WeekdaySelector> {
  int selectedIndex = 2; // Default selected (e.g., Wednesday)

  final List<Map<String, String>> days = [
    {"day": "Mon", "date": "20"},
    {"day": "Tue", "date": "20"},
    {"day": "Wed", "date": "20"},
    {"day": "Thu", "date": "20"},
    {"day": "Fri", "date": "20"},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(days.length, (index) {
        final item = days[index];
        return DayTile(
          day: item['day']!,
          date: item['date']!,
          isSelected: selectedIndex == index,
          onTap: () {
            setState(() => selectedIndex = index);
          },
        );
      }),
    );
  }
}
