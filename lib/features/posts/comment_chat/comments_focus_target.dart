import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

abstract class CommentsFocusTarget {
  const CommentsFocusTarget();
}

class CommentsFocusTargetNone implements CommentsFocusTarget {
  const CommentsFocusTargetNone();
}

class CommentsFocusTargetComment implements CommentsFocusTarget {
  CommentsFocusTargetComment(this.comment);

  final TreeComment comment;
}

class CommentsFocusTargetViewportEnd implements CommentsFocusTarget {
  // The constructor is intentionally non-const, to make different instances not equal
  CommentsFocusTargetViewportEnd();
}
