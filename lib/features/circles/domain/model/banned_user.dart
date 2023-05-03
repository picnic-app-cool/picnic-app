import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';

abstract class BannedUser {
  Id get userId;

  String get userName;

  String get userAvatar;

  BanType get banType;
}
