import 'package:flutter/cupertino.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

//ignore_for_file: unused-code, unused-files
class SliceHeaderView extends StatelessWidget {
  const SliceHeaderView({
    required this.title,
    required this.buttonText,
    this.onTapInvite,
    Key? key,
  }) : super(key: key);

  final String title;
  final String buttonText;
  final VoidCallback? onTapInvite;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: styles.title30,
            ),
          ),
          if (onTapInvite != null)
            PicnicTextButton(
              label: buttonText,
              labelStyle: styles.title20.copyWith(
                color: theme.colors.green,
              ),
              onTap: onTapInvite,
              alignment: AlignmentDirectional.centerEnd,
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}
