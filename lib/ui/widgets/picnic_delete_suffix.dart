import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicDeleteSuffix extends StatelessWidget {
  const PicnicDeleteSuffix({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  static const _size = 20.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;

    const _radius = Constants.borderRadiusM;
    const _padding = 5.0;
    const _buttonColorOpacity = 0.5;

    void _clearTextField() {
      controller.clear();
    }

    return InkWell(
      borderRadius: BorderRadius.circular(_radius),
      onTap: _clearTextField,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: colors.darkBlue.shade200.withOpacity(_buttonColorOpacity),
            borderRadius: BorderRadius.circular(_radius),
          ),
          height: _size,
          width: _size,
          padding: const EdgeInsets.all(_padding),
          child: Image.asset(
            Assets.images.close.path,
            color: colors.blackAndWhite.shade200,
          ),
        ),
      ),
    );
  }
}
