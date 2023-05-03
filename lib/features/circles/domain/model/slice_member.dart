import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

//ignore_for_file: unused-code, unused-files
class SliceMember extends Equatable {
  const SliceMember({
    required this.user,
    required this.role,
    required this.sliceId,
    required this.userId,
    required this.joinedAtString,
    required this.bannedAtString,
  });

  const SliceMember.empty()
      : user = const PublicProfile.empty(),
        role = SliceRole.owner,
        sliceId = const Id(''),
        userId = const Id(''),
        joinedAtString = '',
        bannedAtString = '';

  final PublicProfile user;
  final SliceRole role;
  final Id sliceId;
  final Id userId;
  final String joinedAtString;
  final String bannedAtString;

  DateTime? get bannedAt => DateTime.tryParse(bannedAtString);

  DateTime? get joinedAt => DateTime.tryParse(joinedAtString);

  @override
  List<Object?> get props => [
        user,
        role,
        sliceId,
        userId,
        joinedAtString,
        bannedAtString,
      ];

  SliceMember copyWith({
    PublicProfile? user,
    SliceRole? role,
    Id? sliceId,
    Id? userId,
    String? joinedAt,
    String? bannedAt,
  }) {
    return SliceMember(
      user: user ?? this.user,
      role: role ?? this.role,
      sliceId: sliceId ?? this.sliceId,
      userId: userId ?? this.userId,
      joinedAtString: joinedAt ?? joinedAtString,
      bannedAtString: bannedAt ?? bannedAtString,
    );
  }
}
