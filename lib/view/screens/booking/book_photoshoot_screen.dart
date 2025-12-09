import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/booking_controller.dart';
import 'package:contento/controller/subscription_controller.dart';
import 'package:contento/models/booking_model.dart';
import 'package:contento/view/screens/booking/booking_confirmation_screen.dart';
import 'package:contento/view/screens/membership/subscription_plans_screen.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookPhotoshootScreen extends StatefulWidget {
  const BookPhotoshootScreen({super.key});

  @override
  State<BookPhotoshootScreen> createState() => _BookPhotoshootScreenState();
}

class _BookPhotoshootScreenState extends State<BookPhotoshootScreen> {
  final BookingController bookingController = Get.put(BookingController());
  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Listen to notes controller changes
    notesController.addListener(() {
      bookingController.setBookingNotes(notesController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            isBackButton: true,
            image: Assets.imagesMyBookingsAppBarLayout,
            title: 'Book Photoshoot',
          ),
          SizedBox(height: 15),

          Expanded(
            child: SingleChildScrollView(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODO: Enable subscription info when needed
                  // Subscription Info (commented for now)
                  // _buildSubscriptionInfo(),
                  // SizedBox(height: 24),

                  // Location Selection
                  _buildSectionTitle("Select Location"),
                  SizedBox(height: 12),
                  _buildLocationSelection(),
                  SizedBox(height: 24),

                  // Date Selection
                  _buildSectionTitle("Select Date"),
                  SizedBox(height: 12),
                  _buildDateSelection(),
                  SizedBox(height: 24),

                  // Time Slot Selection
                  Obx(() {
                    if (bookingController.selectedLocation.value != null &&
                        bookingController.selectedDate.value != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Select Time Slot"),
                          SizedBox(height: 12),
                          _buildTimeSlotSelection(),
                          SizedBox(height: 24),
                        ],
                      );
                    }
                    return SizedBox();
                  }),

                  // Notes
                  _buildSectionTitle("Additional Notes (Optional)"),
                  SizedBox(height: 12),
                  CustomTextField(
                    controller: notesController,
                    hintText: "Any special requirements or notes...",
                    maxLines: 3,
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Book Button
          Container(
            padding: AppSizes.HORIZONTAL,
            margin: EdgeInsets.only(bottom: 20),
            child: Obx(() {
              bool canBook = bookingController.isBookingFormComplete &&
                  subscriptionController.hasActiveSubscription &&
                  !bookingController.isLoading.value;

              return MyButton(
                onTap: canBook ? _bookPhotoshoot : _handleBookingAction,
                buttonText: bookingController.isLoading.value
                    ? "Booking..."
                    : canBook
                        ? "Book Photoshoot (\$${subscriptionController.remainingCredits} credits left)"
                        : _getBookButtonText(),
                fontColor: kWhiteColor,
                gradient1:
                    canBook ? kPrimaryColor : kSecondaryColor.withOpacity(0.7),
                gradient2: canBook
                    ? kSecondaryColor
                    : kSecondaryColor.withOpacity(0.5),
                fontSize: 16,
              );
            }),
          ),
        ],
      ),
    );
  }

  // TODO: Enable when subscription is active
  // Widget _buildSubscriptionInfo() {
  //   return Obx(() {
  //     return Container(
  //       padding: EdgeInsets.all(16),
  //       decoration: AppStyling().myDecoration(
  //         color: subscriptionController.hasActiveSubscription
  //             ? kPrimaryColor.withOpacity(0.1)
  //             : Colors.orange.withOpacity(0.1),
  //         borderColor: subscriptionController.hasActiveSubscription
  //             ? kPrimaryColor
  //             : Colors.orange,
  //         radius: 12,
  //       ),
  //       child: Row(
  //         children: [
  //           Icon(
  //             subscriptionController.hasActiveSubscription
  //                 ? Icons.check_circle
  //                 : Icons.warning,
  //             color: subscriptionController.hasActiveSubscription
  //                 ? kPrimaryColor
  //                 : Colors.orange,
  //             size: 24,
  //           ),
  //           SizedBox(width: 12),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 MyText(
  //                   text: subscriptionController.hasActiveSubscription
  //                       ? "${subscriptionController.subscriptionTypeName} Plan"
  //                       : "No Active Subscription",
  //                   size: 16,
  //                   weight: FontWeight.w600,
  //                   color: kSecondaryColor,
  //                 ),
  //                 SizedBox(height: 4),
  //                 MyText(
  //                   text: subscriptionController.hasActiveSubscription
  //                       ? "${subscriptionController.remainingCredits} credits remaining"
  //                       : "Purchase a plan to book photoshoots",
  //                   size: 14,
  //                   weight: FontWeight.w400,
  //                   color: kSecondaryColor.withOpacity(0.7),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   });
  // }

  Widget _buildSectionTitle(String title) {
    return MyText(
      text: title,
      size: 18,
      weight: FontWeight.w600,
      color: kSecondaryColor,
    );
  }

  Widget _buildLocationSelection() {
    return Obx(() {
      return Column(
        children: bookingController.availableLocations.map((location) {
          bool isSelected =
              bookingController.selectedLocation.value?.id == location.id;

          return GestureDetector(
            onTap: () => bookingController.setSelectedLocation(location),
            child: Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: AppStyling().myDecoration(
                color:
                    isSelected ? kPrimaryColor.withOpacity(0.1) : kWhiteColor,
                borderColor: isSelected
                    ? kPrimaryColor
                    : kSecondaryColor.withOpacity(0.3),
                radius: 12,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: kSecondaryColor.withOpacity(0.1),
                      child: location.imageUrls.isNotEmpty
                          ? Image.network(
                              location.imageUrls.first,
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.location_on, color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: location.name,
                          size: 16,
                          weight: FontWeight.w600,
                          color: kSecondaryColor,
                        ),
                        SizedBox(height: 4),
                        MyText(
                          text: location.address,
                          size: 14,
                          weight: FontWeight.w400,
                          color: kSecondaryColor.withOpacity(0.7),
                        ),
                        SizedBox(height: 4),
                        MyText(
                          text: location.description,
                          size: 12,
                          weight: FontWeight.w400,
                          color: kSecondaryColor.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: kPrimaryColor, size: 24),
                ],
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Widget _buildDateSelection() {
    return Obx(() {
      DateTime selectedDate =
          bookingController.selectedDate.value ?? DateTime.now();

      return GestureDetector(
        onTap: _selectDate,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: AppStyling().myDecoration(
            color: bookingController.selectedDate.value != null
                ? kPrimaryColor.withOpacity(0.1)
                : kWhiteColor,
            borderColor: bookingController.selectedDate.value != null
                ? kPrimaryColor
                : kSecondaryColor.withOpacity(0.3),
            radius: 12,
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: kPrimaryColor,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: MyText(
                  text: bookingController.selectedDate.value != null
                      ? bookingController.formatBookingDate(selectedDate)
                      : "Select a date",
                  size: 16,
                  weight: FontWeight.w500,
                  color: kSecondaryColor,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: kSecondaryColor,
                size: 24,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildTimeSlotSelection() {
    return Obx(() {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: bookingController.availableTimeSlots.map((timeSlot) {
          bool isSelected =
              bookingController.selectedTimeSlot.value == timeSlot;

          return GestureDetector(
            onTap: () => bookingController.setSelectedTimeSlot(timeSlot),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: AppStyling().myDecoration(
                color: isSelected ? kPrimaryColor : kWhiteColor,
                borderColor: isSelected
                    ? kPrimaryColor
                    : kSecondaryColor.withOpacity(0.3),
                radius: 8,
              ),
              child: MyText(
                text: timeSlot,
                size: 14,
                weight: FontWeight.w500,
                color: isSelected ? kWhiteColor : kSecondaryColor,
              ),
            ),
          );
        }).toList(),
      );
    });
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (picked != null) {
      bookingController.setSelectedDate(picked);
    }
  }

  void _bookPhotoshoot() async {
    bool success = await bookingController.createBooking();
    if (success) {
      Get.to(() => BookingConfirmationScreen());
    }
  }

  void _handleBookingAction() {
    if (!subscriptionController.hasActiveSubscription) {
      Get.to(() => SubscriptionPlansScreen());
    }
  }

  String _getBookButtonText() {
    if (!subscriptionController.hasActiveSubscription) {
      return "Get Subscription to Book";
    } else if (subscriptionController.remainingCredits <= 0) {
      return "No Credits Left - Renew Plan";
    } else if (!bookingController.isBookingFormComplete) {
      return "Complete Booking Details";
    }
    return "Book Photoshoot";
  }
}
