import 'package:contento/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';

class IosSwitch extends StatelessWidget {
  final Function(dynamic)? onChange;
  final bool value;
  final Color activeColor, inActiveColor;
  const IosSwitch({
    super.key,
    this.onChange,
    this.value = true,
    this.activeColor = kQuaternaryColor,
    this.inActiveColor = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: CupertinoSwitch(
        activeColor: activeColor,
        thumbColor: (value) ? kPrimaryColor : kPrimaryColor,
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
