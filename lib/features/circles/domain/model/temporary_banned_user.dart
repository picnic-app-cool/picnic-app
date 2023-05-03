import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';

class TemporaryBannedUser extends Equatable implements BannedUser {
  const TemporaryBannedUser({
    required this.userId,
    required this.userName,
    required this.unbanTimeStamp,
    required this.userAvatar,
  });

  TemporaryBannedUser.empty()
      : userId = const Id.empty(),
        userName = '',
        userAvatar = '',
        unbanTimeStamp = DateTime(1970);

  final DateTime unbanTimeStamp;

  @override
  final Id userId;

  @override
  final String userName;

  @override
  final String userAvatar;

  @override
  BanType get banType => BanType.temporary;

  @override
  List<Object?> get props => [
        userId,
        userName,
        userAvatar,
        unbanTimeStamp,
      ];

  TemporaryBannedUser copyWith({
    Id? userId,
    String? userName,
    String? userAvatar,
    DateTime? unbanTimeStamp,
  }) {
    return TemporaryBannedUser(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      unbanTimeStamp: unbanTimeStamp ?? this.unbanTimeStamp,
    );
  }
}
