import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class DownArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Image.asset(
        Assets.images.arrowDown.path,
        width: Constants.downArrowWidthAppBar,
      );
}
