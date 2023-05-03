import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// Minimal data required to represent user's public profile (useful on lists of users, post authors etc)
abstract class MinimalPublicProfile {
  bool get iFollow;

  bool get isVerified;

  String get username;

  ImageUrl get profileImageUrl;

  Id get id;
}
