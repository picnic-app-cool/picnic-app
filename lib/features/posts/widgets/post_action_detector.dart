import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class PostActionDetector extends StatelessWidget {
  const PostActionDetector({
    Key? key,
    required this.post,
    required this.onReport,
    required this.child,
  }) : super(key: key);

  final Post post;
  final Widget child;
  final Function(Post) onReport;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onLongPress: () => onReport(post),
        child: child,
      );
}
