import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/view/screens/my_nav_bar/my_nav_bar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingConfirmationScreen extends StatelessWidget {
  const BookingConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kQuaternaryColor,
      body: SafeArea(
        child: Padding(
          padding: AppSizes.HORIZONTAL,
          child: Column(
            children: [
              SizedBox(height: 60),

              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [kPrimaryColor, kSecondaryColor],
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: kWhiteColor,
                  size: 60,
                ),
              ),

              SizedBox(height: 32),

              // Success Message
              MyText(
                text: "Booking Confirmed!",
                size: 28,
                weight: FontWeight.w700,
                color: kSecondaryColor,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16),

              MyText(
                text:
                    "Your photoshoot has been successfully booked. You'll receive a confirmation email shortly.",
                size: 16,
                weight: FontWeight.w400,
                color: kSecondaryColor.withOpacity(0.7),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              // Info Container
              Container(
                padding: EdgeInsets.all(24),
                decoration: AppStyling().myDecoration(
                  color: kWhiteColor,
                  borderColor: kPrimaryColor.withOpacity(0.3),
                  radius: 16,
                ),
                child: Column(
                  children: [
                    _buildInfoRow(
                      icon: Icons.schedule,
                      title: "What's Next?",
                      subtitle:
                          "We'll send you reminder notifications 24 hours and 2 hours before your session.",
                    ),
                    SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.camera_alt,
                      title: "Preparation Tips",
                      subtitle:
                          "Arrive 10 minutes early and bring any props or outfit changes you'd like to use.",
                    ),
                    SizedBox(height: 20),
                    _buildInfoRow(
                      icon: Icons.photo_library,
                      title: "Your Photos",
                      subtitle:
                          "Edited photos will be available in your gallery within 48 hours after the session.",
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Action Buttons
              Column(
                children: [
                  MyButton(
                    onTap: () {
                      Get.offAll(() =>
                          MyNavBar(selectedIndex: 3)); // Go to bookings tab
                    },
                    buttonText: "View My Bookings",
                    fontColor: kWhiteColor,
                    gradient1: kPrimaryColor,
                    gradient2: kSecondaryColor,
                    fontSize: 16,
                  ),
                  SizedBox(height: 12),
                  MyButton(
                    onTap: () {
                      Get.offAll(
                          () => MyNavBar(selectedIndex: 0)); // Go to home
                    },
                    buttonText: "Back to Home",
                    fontColor: kPrimaryColor,
                    gradient1: kWhiteColor,
                    gradient2: kWhiteColor,
                    fontSize: 16,
                  ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: kPrimaryColor,
            size: 20,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: title,
                size: 16,
                weight: FontWeight.w600,
                color: kSecondaryColor,
              ),
              SizedBox(height: 4),
              MyText(
                text: subtitle,
                size: 14,
                weight: FontWeight.w400,
                color: kSecondaryColor.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
