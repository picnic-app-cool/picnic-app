import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/ban_type.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';

class PermanentBannedUser extends Equatable implements BannedUser {
  const PermanentBannedUser({
    required this.userId,
    required this.userName,
    required this.userAvatar,
  });

  const PermanentBannedUser.empty()
      : userId = const Id.empty(),
        userName = '',
        userAvatar = '';

  @override
  final Id userId;

  @override
  final String userName;

  @override
  final String userAvatar;

  @override
  BanType get banType => BanType.permanent;

  @override
  List<Object?> get props => [
        userId,
        userName,
        userAvatar,
      ];

  PermanentBannedUser copyWith({
    Id? userId,
    String? userName,
    String? userAvatar,
  }) {
    return PermanentBannedUser(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
    );
  }
}
