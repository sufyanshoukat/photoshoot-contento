import 'package:contento/constants/app_colors.dart';
import 'package:contento/constants/app_images.dart';
import 'package:contento/view/widget/general_appbar.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageMemberShipPage extends StatefulWidget {
  const ManageMemberShipPage({super.key});

  @override
  State<ManageMemberShipPage> createState() => _ManageMemberShipPageState();
}

class _ManageMemberShipPageState extends State<ManageMemberShipPage> {
  List<OffersModel> offerList = [
    OffersModel(
      title: "Trial Shoot- Non members",
      price: "149",
      subTitle: "One time Payment",
      offers: [
        'First timers ',
        'Includes 50-60 images',
        '3-6 Reels (optional)',
      ],
    ),
    OffersModel(
      title: "Content Concierge",
      price: "599",
      subTitle: "month",
      offers: [
        'Includes 4 shoots to use in the next 12 months',
        '50-60 digital images per shoot',
        '3-6  Reels per shoot (optional)',
        'Renews annually until cancelled',
      ],
    ),
    OffersModel(
      title: "Additional Shoot Members",
      price: "249",
      subTitle: "1 time payment",
      offers: [
        'Current members only',
        'Includes 50-60 images',
        '3-6 Reels (optional)',
      ],
    ),
    OffersModel(
      title: "Quarterly Membership",
      price: "749",
      subTitle: "1 time payment",
      offers: [
        'Includes 4 shoots to use in the next 12 months',
        '50-60 digital images per shoot',
        '3-6  Reels per shoot (optional)',
        'Renews annually until cancelled',
      ],
    ),
    OffersModel(
      title: "Monthly Membership",
      price: "189",
      subTitle: "/ mon",
      offers: [
        'Includes 4 shoots to use in the next 12 months',
        '50-60 digital images per shoot',
        '3-6  Reels per shoot (optional)',
        'Renews annually until cancelled',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GeneralAppBar(
            image: Assets.imagesMyBookingsAppBarLayout,
            title: 'Manage Membership',
          ),
          SizedBox(height: 15),
          MyText(
            paddingBottom: 15,
            paddingLeft: 20,
            text: "Premium Membership",
            size: 18,
            weight: FontWeight.w500,
            color: kBlackColor,
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: offerList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                mainAxisExtent: 240,
              ),
              itemBuilder: (context, index) {
                return _PriceCard(
                  title: offerList[index].title,
                  price: offerList[index].price,
                  subTitle: offerList[index].subTitle,
                  offers: offerList[index].offers,
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String? title, price, subTitle;
  final List<String> offers;
  final VoidCallback? onTap;
  const _PriceCard({
    super.key,
    required this.offers,
    this.title,
    this.price,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      // margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: kWhiteColor.withValues(alpha: 0.3), width: 2),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xff6C7278), Color(0xff323332)],
        ),
        borderRadius: BorderRadius.circular(17),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ------ Title ------
          MyText(
            paddingBottom: 2,
            text: title ?? "Trial Shoot- Non members",
            size: 16,
            weight: FontWeight.w400,
            color: kWhiteColor,
          ),

          // ------ Price ------
          Row(
            children: [
              MyText(
                text: "\$$price",
                size: 14,
                weight: FontWeight.w800,
                color: kWhiteColor,
              ),
              MyText(
                text: "/ $subTitle",
                size: 10,
                weight: FontWeight.w400,
                color: kWhiteColor,
              ),
            ],
          ),

          SizedBox(height: 5),

          // ------ Include ------
          Column(
            children: List.generate(offers.length, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, color: kWhiteColor, size: 16),
                    Expanded(
                      child: MyText(
                        paddingLeft: 5,
                        text: offers[index],
                        size: 10,
                        weight: FontWeight.w400,
                        color: kWhiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class OffersModel {
  String title;
  String price;
  String subTitle;
  List<String> offers;

  OffersModel({
    required this.title,
    required this.price,
    required this.subTitle,
    required this.offers,
  });
}
