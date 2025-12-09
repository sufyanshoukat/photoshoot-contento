import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/view/screens/auth/login.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final onboardingBK = [
    Assets.imagesOnboarding1,
    Assets.imagesOnboarding2,
    Assets.imagesOnboarding3,
  ];

  bool _imagesCached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Run this only once
    if (!_imagesCached) {
      _imagesCached = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTransperentColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(onboardingBK[currentPage]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 100, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: List.generate(
                demoData.length,
                (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
          ),

          Padding(
            padding: AppSizes.DEFAULT,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Expanded(
                  flex: 14,
                  child: PageView.builder(
                    itemCount: demoData.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) => OnboardContent(
                      // illustration: demoData[index]["illustration"],
                      title: demoData[index]["title"],
                      text: demoData[index]["text"],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Align(
                  alignment: Alignment.center,
                  child: MyButton(
                    onTap: () {
                      if (currentPage < 2) {
                        currentPage++;
                        setState(() {});
                      } else {
                        Get.to(() => LoginPage());
                      }
                    },
                    buttonText: currentPage < 2 ? "Next" : "Get Started",
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    // required this.illustration,
    required this.title,
    required this.text,
  });

  final String? title, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacer(),
        MyText(
          text: title.toString(),
          size: 28,
          weight: FontWeight.w700,
          color: kPrimaryColor,
        ),
        MyText(
          paddingTop: 19,
          text: text.toString(),
          size: 16,
          weight: FontWeight.w400,
          color: kPrimaryColor,
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.activeColor = kPrimaryColor,
    this.inActiveColor = Colors.white10,
  });

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 16 / 2),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "title": "Capture Moments. Simplified.",
    "text":
        "Book professional photo shoots effortlessly using your membership credits.",
  },
  {
    "title": "Find Your Perfect Time.",
    "text":
        "Choose from available dates, times, and weekly locations all in just a few taps.",
  },
  {
    "title": "Enjoy Exclusive Access",
    "text":
        "Use your monthly or quarterly credits to book shoots anytime, and track them easily in your dashboard.",
  },
];
