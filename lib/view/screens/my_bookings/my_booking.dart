import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/booking_controller.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/models/booking_model.dart';
import 'package:contento/view/screens/booking/book_photoshoot_screen.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBookingPage extends StatefulWidget {
  final bool haveBackButton;
  const MyBookingPage({super.key, this.haveBackButton = true});

  @override
  State<MyBookingPage> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  final BookingController bookingController = Get.put(BookingController());
  final AuthController authController = Get.find<AuthController>();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    final userId = authController.currentUser.value?.uid;
    if (userId != null) {
      bookingController.getUserBookings(userId);
    }
  }

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

            // --------- Bookings List -----------
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Obx(() {
                List<BookingModel> bookingsToShow = selectedIndex == 0
                    ? bookingController.upcomingBookings
                    : bookingController.completedBookings;

                if (bookingController.isLoading.value) {
                  return SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (bookingsToShow.isEmpty) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            selectedIndex == 0
                                ? Icons.calendar_today
                                : Icons.photo_camera,
                            size: 48,
                            color: kSecondaryColor.withOpacity(0.5),
                          ),
                          SizedBox(height: 16),
                          MyText(
                            text: selectedIndex == 0
                                ? "No upcoming bookings"
                                : "No completed sessions yet",
                            size: 16,
                            weight: FontWeight.w500,
                            color: kSecondaryColor.withOpacity(0.7),
                          ),
                          SizedBox(height: 8),
                          MyText(
                            text: selectedIndex == 0
                                ? "Book your first photoshoot!"
                                : "Complete a session to see photos here",
                            size: 14,
                            weight: FontWeight.w400,
                            color: kSecondaryColor.withOpacity(0.5),
                          ),
                          if (selectedIndex == 0) ...[
                            SizedBox(height: 16),
                            SizedBox(
                              width: 160,
                              child: MyButton(
                                onTap: () =>
                                    Get.to(() => BookPhotoshootScreen()),
                                buttonText: "Book Photoshoot",
                                fontColor: kWhiteColor,
                                gradient1: kPrimaryColor,
                                gradient2: kSecondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: List.generate(bookingsToShow.length, (index) {
                    final booking = bookingsToShow[index];
                    return BookingCard(booking: booking, index: index);
                  }),
                );
              }),
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

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final int index;

  const BookingCard({super.key, required this.booking, required this.index});

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.find<BookingController>();

    return Container(
      margin: EdgeInsets.only(top: (index == 0) ? 12 : 10),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      decoration: AppStyling().gradientStyle1(),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.camera_alt, color: kWhiteColor, size: 24),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "Photoshoot Session",
                      size: 17,
                      weight: FontWeight.w600,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: 5),
                    MyText(
                      text:
                          "${bookingController.formatBookingDate(booking.bookingDate)} • ${booking.timeSlot}",
                      size: 13,
                      weight: FontWeight.w400,
                      color: kWhiteColor,
                    ),
                    SizedBox(height: 2),
                    MyText(
                      text: "Status: ${booking.statusDisplayName}",
                      size: 12,
                      weight: FontWeight.w400,
                      color: kWhiteColor.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(booking.status),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MyText(
                  text: booking.statusDisplayName.toUpperCase(),
                  size: 10,
                  weight: FontWeight.w600,
                  color: kWhiteColor,
                ),
              ),
            ],
          ),
          if (booking.notes.isNotEmpty) ...[
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: kWhiteColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: MyText(
                text: "Notes: ${booking.notes}",
                size: 12,
                weight: FontWeight.w400,
                color: kWhiteColor,
              ),
            ),
          ],
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: MyButton(
                    onTap: () => Get.to(() => BookPhotoshootScreen()),
                    buttonText: "Book Another",
                    fontColor: kWhiteColor,
                    gradient1: kPrimaryColor,
                    gradient2: kSecondaryColor,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.orange;
      case BookingStatus.confirmed:
        return kPrimaryColor;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }
}
