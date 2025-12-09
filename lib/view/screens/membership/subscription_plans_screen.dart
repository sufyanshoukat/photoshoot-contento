import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/constants/app_styling.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/controller/subscription_controller.dart';
import 'package:contento/models/subscription_model.dart';
import 'package:contento/view/screens/my_nav_bar/my_nav_bar.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final AuthController authController = Get.find<AuthController>();

  int selectedPlanIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            isBackButton: true,
            image: Assets.imagesMyBookingsAppBarLayout,
            title: 'Choose Your Plan',
          ),
          SizedBox(height: 20),

          // Header
          Padding(
            padding: AppSizes.HORIZONTAL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "Select the perfect plan for your photography needs",
                  size: 16,
                  weight: FontWeight.w400,
                  color: kSecondaryColor,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),

          // Plans List
          Expanded(
            child: Obx(() {
              if (subscriptionController.availablePlans.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                padding: AppSizes.HORIZONTAL,
                itemCount: subscriptionController.availablePlans.length,
                itemBuilder: (context, index) {
                  final plan = subscriptionController.availablePlans[index];
                  final isSelected = selectedPlanIndex == index;
                  final isPopular = plan.type == SubscriptionType.quarterly;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPlanIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: AppStyling().myDecoration(
                        borderColor: isSelected
                            ? kPrimaryColor
                            : kSecondaryColor.withOpacity(0.3),
                        color: isSelected
                            ? kPrimaryColor.withOpacity(0.05)
                            : kWhiteColor,
                        radius: 12,
                      ),
                      child: Stack(
                        children: [
                          // Popular Badge
                          if (isPopular)
                            Positioned(
                              top: 0,
                              right: 20,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8),
                                  ),
                                ),
                                child: MyText(
                                  text: "MOST POPULAR",
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),

                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Plan Name & Price
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText(
                                            text: plan.name,
                                            size: 20,
                                            weight: FontWeight.w700,
                                            color: kSecondaryColor,
                                          ),
                                          SizedBox(height: 4),
                                          MyText(
                                            text: plan.description,
                                            size: 14,
                                            weight: FontWeight.w400,
                                            color: kSecondaryColor
                                                .withOpacity(0.7),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        MyText(
                                          text:
                                              "\$${plan.price.toStringAsFixed(2)}",
                                          size: 24,
                                          weight: FontWeight.w700,
                                          color: kPrimaryColor,
                                        ),
                                        MyText(
                                          text: "/${plan.type.name}",
                                          size: 14,
                                          weight: FontWeight.w400,
                                          color:
                                              kSecondaryColor.withOpacity(0.7),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),

                                // Credits
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: AppStyling().myDecoration(
                                    color: kPrimaryColor.withOpacity(0.1),
                                    borderColor: kTransperentColor,
                                    radius: 8,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                        color: kPrimaryColor,
                                      ),
                                      SizedBox(width: 8),
                                      MyText(
                                        text: "${plan.credits} Photo shoots",
                                        size: 16,
                                        weight: FontWeight.w600,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 16),

                                // Features
                                Column(
                                  children: plan.features.map((feature) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 16,
                                            color: kPrimaryColor,
                                          ),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: MyText(
                                              text: feature,
                                              size: 14,
                                              weight: FontWeight.w400,
                                              color: kSecondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Subscribe Button
          Container(
            padding: AppSizes.HORIZONTAL,
            margin: EdgeInsets.only(bottom: 20),
            child: Obx(() {
              bool canSubscribe = selectedPlanIndex >= 0 &&
                  !subscriptionController.isLoading.value;

              return MyButton(
                onTap: canSubscribe ? _subscribeToPlan : () {},
                buttonText: subscriptionController.isLoading.value
                    ? "Processing..."
                    : "Subscribe Now",
                fontColor: kWhiteColor,
                gradient1: canSubscribe
                    ? kPrimaryColor
                    : kSecondaryColor.withOpacity(0.5),
                gradient2: canSubscribe
                    ? kSecondaryColor
                    : kSecondaryColor.withOpacity(0.3),
                fontSize: 16,
              );
            }),
          ),
        ],
      ),
    );
  }

  void _subscribeToPlan() async {
    if (selectedPlanIndex < 0) return;

    final plan = subscriptionController.availablePlans[selectedPlanIndex];
    final userId = authController.currentUser.value?.uid;

    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    bool success = await subscriptionController.createSubscription(
      userId: userId,
      type: plan.type,
      price: plan.price,
      credits: plan.credits,
      duration: plan.duration,
    );

    if (success) {
      // Navigate to home screen
      Get.offAll(() => MyNavBar());
    }
  }
}
