import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/view/screens/settings/update_profile.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool isObsecureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GeneralAppBar(image: Assets.imagesAuthTopBk, title: 'Help Center'),
            SizedBox(height: 11),
            SizedBox(height: 16),
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  SettingButton(
                    icon: Assets.imagesHelpGlobeIcon,
                    title: "help@gmail.com",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
