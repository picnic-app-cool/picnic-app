import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class CommentsKeyStorage {
  final Map<TreeComment, GlobalKey> _commentToKey = {};

  GlobalKey resolveKey(TreeComment comment) {
    return _commentToKey[comment] ??= GlobalKey();
  }

  BuildContext? resolveContext(TreeComment comment) {
    return _commentToKey[comment]?.currentContext;
  }
}
