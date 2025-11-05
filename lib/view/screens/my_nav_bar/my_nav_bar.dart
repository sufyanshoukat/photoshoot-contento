import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/view/screens/home/home.dart';
import 'package:contento/view/screens/location_selection/location_selection.dart';
import 'package:contento/view/screens/membership/member_ship_detail.dart';
import 'package:contento/view/screens/my_bookings/my_booking.dart';
import 'package:contento/view/screens/settings/settings.dart';
import 'package:contento/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyNavBar extends StatefulWidget {
  int selectedIndex;
  MyNavBar({super.key, this.selectedIndex = 0});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  //int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  List<Widget> screens = [
    HomePage(),
    LocationSelectionPage(),
    MemberShipDetailPage(),
    MyBookingPage(haveBackButton: false),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: screens[widget.selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kSecondaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: kSecondaryColor,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        // selectedLabelStyle: TextStyle(
        //   fontWeight: FontWeight.w500,
        //   fontFamily: AppFonts.SF_PRO_DISPLAY,
        // ),
        // unselectedLabelStyle: TextStyle(
        //   fontWeight: FontWeight.w400,
        //   fontFamily: AppFonts.SF_PRO_DISPLAY,
        // ),
        items: [
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MyNavItems(
              fillIcon: Assets.imagesBHomeOne,
              outlineIcon: Assets.imagesBHomeOne,
              selectedColor: (widget.selectedIndex == 0) ? true : false,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MyNavItems(
              fillIcon: Assets.imagesBSearchOne,
              outlineIcon: Assets.imagesBSearchOne,
              selectedColor: (widget.selectedIndex == 1) ? true : false,
            ),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MyNavItems(
              iconHeight: 18,
              fillIcon: Assets.imagesBMemberOne,
              outlineIcon: Assets.imagesBMemberOne,
              selectedColor: (widget.selectedIndex == 2) ? true : false,
            ),
            label: 'Clubhouse ',
          ),
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MyNavItems(
              iconHeight: 22,
              fillIcon: Assets.imagesBBookingOne,
              outlineIcon: Assets.imagesBBookingOne,
              selectedColor: (widget.selectedIndex == 3) ? true : false,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            backgroundColor: kPrimaryColor,
            icon: MyNavItems(
              fillIcon: Assets.imagesBProfileOne,
              outlineIcon: Assets.imagesBProfileOne,
              selectedColor: (widget.selectedIndex == 4) ? true : false,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class MyNavItems extends StatelessWidget {
  final String? outlineIcon, fillIcon;
  final bool selectedColor;
  final double iconHeight;
  const MyNavItems({
    super.key,
    this.outlineIcon,
    this.selectedColor = false,
    this.fillIcon,
    this.iconHeight = 20,
  });

  @override
  Widget build(BuildContext context) {
    return CommonImageView(
      height: iconHeight,
      // width: 24,
      imagePath: (selectedColor) ? fillIcon : outlineIcon,
      imageColor: (selectedColor) ? kWhiteColor : kGreyTextColor,
    );
  }
}
