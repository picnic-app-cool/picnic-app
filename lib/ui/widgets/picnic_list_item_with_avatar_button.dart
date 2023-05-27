import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PicnicListItemWithAvatarButton extends StatefulWidget {
  const PicnicListItemWithAvatarButton({
    Key? key,
    required this.isActive,
    this.isVerified = false,
    required this.onTapButton,
    required this.activeText,
    required this.passiveText,
    required this.title,
    required this.onTapView,
    required this.showFollowButton,
    required this.picnicAvatar,
  }) : super(key: key);

  final bool isActive;

  final VoidCallback onTapButton;

  final String activeText;

  final String passiveText;

  final String title;

  final VoidCallback onTapView;

  final bool showFollowButton;

  final bool isVerified;

  final Widget picnicAvatar;

  @override
  State<PicnicListItemWithAvatarButton> createState() => _PicnicListItemWithAvatarButtonState();
}

class _PicnicListItemWithAvatarButtonState extends State<PicnicListItemWithAvatarButton> {
  late bool _isActive;
  static const _buttonBorderWith = 2.0;
  static const _height = 62.0;

  @override
  void initState() {
    _isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final pink = colors.pink.shade500;
    final blue = colors.blue.shade500;
    final white = colors.blackAndWhite.shade100;

    return PicnicListItem(
      height: _height,
      onTap: widget.onTapView,
      title: widget.title,
      titleStyle: styles.subtitle20,
      leftGap: 0,
      leading: widget.picnicAvatar,
      trailingGap: 0,
      trailing: widget.showFollowButton
          ? PicnicButton(
              title: _isActive ? widget.activeText : widget.passiveText,
              onTap: _onTapButton,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              titleColor: _isActive ? pink : white,
              borderWidth: _buttonBorderWith,
              borderColor: _isActive ? pink : blue,
              color: _isActive ? white : blue,
              style: PicnicButtonStyle.outlined,
            )
          : null,
    );
  }

  void _onTapButton() {
    widget.onTapButton();
    setState(() {
      _isActive = !_isActive;
    });
  }
}
