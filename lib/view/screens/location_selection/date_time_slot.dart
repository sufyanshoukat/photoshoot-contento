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
  int selectedSlot = 0;

  // Available time slots - Wednesdays only: 10am, 11am, 12pm
  // TODO: Add more slots later as needed
  final List<String> availableSlots = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            image: Assets.imagesTimeSlotAppBarLayout,
            title: 'Select Date & Time',
            subTitle: "Choose an available Wednesday for your photoshoot.",
          ),

          SizedBox(height: 32),
          WednesdaySelector(),
          SizedBox(height: 32),
          MyText(
            paddingBottom: 10,
            paddingLeft: 20,
            text: "Available Time Slots:",
            size: 22,
            weight: FontWeight.w500,
          ),

          // Available Time Slots - Wednesdays: 10am, 11am, 12pm
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(availableSlots.length, (index) {
                return InkWell(
                  onTap: () {
                    selectedSlot = index;
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: selectedSlot == index
                        ? BoxDecoration(
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
                      text: availableSlots[index],
                      weight: FontWeight.w500,
                      size: 16,
                      color: selectedSlot == index ? kWhiteColor : kBlackColor,
                    ),
                  ),
                );
              }),
            ),
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
          gradient: isSelected
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

class WednesdaySelector extends StatefulWidget {
  const WednesdaySelector({super.key});

  @override
  State<WednesdaySelector> createState() => _WednesdaySelectorState();
}

class _WednesdaySelectorState extends State<WednesdaySelector> {
  int selectedIndex = 0;
  late List<DateTime> upcomingWednesdays;

  @override
  void initState() {
    super.initState();
    upcomingWednesdays = _getUpcomingWednesdays(5); // Get next 5 Wednesdays
  }

  // Get upcoming Wednesdays starting from today
  List<DateTime> _getUpcomingWednesdays(int count) {
    List<DateTime> wednesdays = [];
    DateTime current = DateTime.now();

    // Find the next Wednesday (or today if it's Wednesday)
    while (current.weekday != DateTime.wednesday) {
      current = current.add(Duration(days: 1));
    }

    // Collect the specified number of Wednesdays
    for (int i = 0; i < count; i++) {
      wednesdays.add(current);
      current = current.add(Duration(days: 7)); // Next Wednesday
    }

    return wednesdays;
  }

  String _getMonthAbbr(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: List.generate(upcomingWednesdays.length, (index) {
          final date = upcomingWednesdays[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: DayTile(
              day: "Wed",
              date: "${date.day} ${_getMonthAbbr(date.month)}",
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() => selectedIndex = index);
              },
            ),
          );
        }),
      ),
    );
  }
}
