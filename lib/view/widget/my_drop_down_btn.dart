import 'package:contento/constants/app_colors.dart';
import 'package:contento/view/widget/my_text_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  final Function(dynamic)? onChanged;
  final List<String> itemsList;
  final String? selectedValue, title, hint;
  final double paddingTop;
  final Color? bkColor, borderColor;
  final FontWeight titleFontWeight;
  const MyDropDown({
    super.key,
    this.onChanged,
    required this.itemsList,
    this.selectedValue,
    this.title,
    this.paddingTop = 8.0,
    this.hint = 'Select',
    this.bkColor,
    this.borderColor,
    this.titleFontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? MyText(
                  text: '$title',
                  size: 12,
                  weight: titleFontWeight,
                  paddingBottom: 8,
                  color: kBlackColor,
                )
              : SizedBox(),
          DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              hint.toString(),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kBlackColor,
              ),
            ),
            items: itemsList
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: kBlackColor,
                      ),
                    ),
                  ),
                )
                .toList(),
            value: selectedValue,
            onChanged: onChanged,
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: kGreyTextColor,
              ),
              //CommonImageView(svgPath: Assets.imagesDropDownIcon),
            ),

            // ----------- Drop Down Style --------------------
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                border: Border.all(color: kQuaternaryColor),
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            // ----------- Button Style --------------------
            underline: SizedBox(),
            buttonStyleData: ButtonStyleData(
              decoration: BoxDecoration(
                color: bkColor ?? kPrimaryColor,
                border: Border.all(color: borderColor ?? kQuaternaryColor),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.only(left: 0, right: 10),
              height: 50,
            ),

            menuItemStyleData: MenuItemStyleData(height: 40),
          ),
        ],
      ),
    );
  }
}
