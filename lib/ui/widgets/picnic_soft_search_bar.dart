import 'package:flutter/material.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_delete_suffix.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';

class PicnicSoftSearchBar extends StatefulWidget {
  const PicnicSoftSearchBar({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText = '',
    this.onChanged,
    this.contentPadding,
    this.hintTextStyle,
  })  : assert(
          controller == null || onChanged == null,
          "you cannot specify both controller and onChanged",
        ),
        super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final Function(String)? onChanged;
  final EdgeInsets? contentPadding;
  final TextStyle? hintTextStyle;

  @override
  State<PicnicSoftSearchBar> createState() => _PicnicSoftSearchBarState();
}

class _PicnicSoftSearchBarState extends State<PicnicSoftSearchBar> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    controller = widget.controller ?? TextEditingController();
    focusNode.addListener(() => setState(() => doNothing()));
    controller.addListener(() => setState(() => doNothing()));
  }

  @override
  void dispose() {
    super.dispose();
    // only dispose focusNode if it was created internally
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    // only dispose controller if it was created internally
    if (widget.controller == null) {
      controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userTyping = focusNode.hasPrimaryFocus && controller.text.isNotEmpty;
    return PicnicTextInput(
      textController: controller,
      prefix: Image.asset(Assets.images.searchGlass.path),
      hintText: widget.hintText,
      focusNode: focusNode,
      onChanged: widget.onChanged,
      padding: 0,
      contentPadding: widget.contentPadding,
      suffix: userTyping ? PicnicDeleteSuffix(controller: controller) : null,
      autocorrect: false,
    );
  }
}
