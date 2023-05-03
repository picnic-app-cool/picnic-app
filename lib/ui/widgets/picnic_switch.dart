import 'package:flutter/cupertino.dart';

class PicnicSwitch extends StatelessWidget {
  const PicnicSwitch({
    Key? key,
    this.color,
    this.size,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final Color? color;
  final double? size;

  final bool value;
  final Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: FittedBox(
        child: CupertinoSwitch(
          activeColor: color,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

abstract class PicnicSwitchSize {
  static double small = 20;
  static double regular = 40;
  static double large = 62;
}
