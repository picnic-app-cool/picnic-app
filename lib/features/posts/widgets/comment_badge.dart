import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/comment_tag.dart';

class CommentBadge extends StatelessWidget {
  const CommentBadge({required this.tag, super.key});

  final CommentTag tag;

  static const _horizontalPadding = 8.0;
  static const _verticalPadding = 4.0;
  static const _borderRadius = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
        vertical: _verticalPadding,
      ),
      decoration: BoxDecoration(
        color: tag.getBackgroundColor(context),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Text(
        tag.label,
        style: TextStyle(color: tag.getColor(context)),
      ),
    );
  }
}
