import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/constants/app_sizes.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:contento/models/country_model.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:contento/view/widget/custom_textfield.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_button.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isObsecureText = false;
  bool checkBoxStatus = false;
  final AuthController authController = Get.find<AuthController>();
  CountryModel? selectedCountry;

  @override
  void initState() {
    super.initState();
    // Set default country to United States
    selectedCountry = countries.first;
  }

  // Show Country Picker Bottom Sheet
  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            MyText(
              text: "Select Country",
              size: 20,
              weight: FontWeight.w700,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    leading: Text(
                      country.flag,
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(country.name),
                    trailing: Text(
                      country.dialCode,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      authController.updateCountry(
                          country.dialCode, country.flag);
                      selectedCountry = country;
                      setState(() {});
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RegisterAppBar(),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: AppSizes.HORIZONTAL,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: authController.firstNameController,
                          haveTitleText: true,
                          labelText: "First Name",
                          hintText: "Lois",
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: CustomTextField(
                          controller: authController.lastNameController,
                          haveTitleText: true,
                          labelText: "Last Name",
                          hintText: "Becket",
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    controller: authController.emailController,
                    top: 16,
                    haveTitleText: true,
                    labelText: "Email",
                    hintText: "example@gmail.com",
                  ),
                  CustomTextField(
                    controller: authController.dobController,
                    top: 16,
                    haveTitleText: true,
                    labelText: "Birth of date",
                    hintText: "18/03/2024",
                    readOnly: true,
                    onTextFieldTap: () => authController.pickDOB(context),
                    haveSuffixIcon: true,
                    suffixWidget: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: CommonImageView(
                          svgPath: Assets.imagesCalenderIcon,
                        ),
                      ),
                    ),
                  ),
                  // Phone Number with Country Code
                  CustomTextField(
                    controller: authController.phoneController,
                    top: 16,
                    haveTitleText: true,
                    labelText: "Phone Number",
                    hintText: "(454) 726-0592",
                    havePrefixIcon: true,
                    preffixWidget: GestureDetector(
                      onTap: () {
                        _showCountryPicker(context);
                      },
                      child: SizedBox(
                        height: 50,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                                  authController.selectedCountryFlag.value,
                                  style: TextStyle(fontSize: 20),
                                )),
                            SizedBox(width: 4),
                            Obx(() => Text(
                                  authController.selectedCountryCode.value,
                                  style: TextStyle(fontSize: 12),
                                )),
                            SizedBox(width: 8),
                            Container(
                              height: 40,
                              width: .5,
                              color: kBlackColor.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  PasswordTextField(
                    controller: authController.passwordController,
                    lebal: "Set Password",
                    isObsecureText: isObsecureText,
                    onTap: () {
                      isObsecureText
                          ? isObsecureText = false
                          : isObsecureText = true;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 16),

                  Obx(() => authController.isLoading.value
                      ? CircularProgressIndicator()
                      : MyButton(
                          mTop: 32,
                          onTap: () {
                            authController.signUpWithEmail();
                          },
                          buttonText: "Sign Up",
                          radius: 100,
                        )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
