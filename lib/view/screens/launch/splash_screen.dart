import 'dart:async';
import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/view/screens/launch/onboarding.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  void splashScreenHandler() {
    // Timer(Duration(seconds: 2), () => Get.to(() => HomeScreen()));
    Timer(Duration(seconds: 2), () {
      Get.offAll(
        () => OnboardingScreen(),
        // LoginPage(),
        // SignUpPage(),
        // HomePage(),
        // LocationSelectionPage(),
        // MyBookingPage(),
        // MemberShipDetailPage(),

        // SettingsPage(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kQuaternaryColor,
      body: Center(
        child: CommonImageView(height: 116, imagePath: Assets.imagesLogo),
      ),
    );
  }
}
