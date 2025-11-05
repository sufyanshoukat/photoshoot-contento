import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool isObsecureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(
              image: Assets.imagesAuthTopBk,
              title: 'Privacy Policy',
            ),
            SizedBox(height: 11),

            SizedBox(height: 16),

            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  CommonImageView(imagePath: Assets.imagesPrivacyPolicy),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
