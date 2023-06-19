import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';

abstract class BasicComment {
  User get author;

  String get text;

  LikeDislikeReaction get myReaction;
}
