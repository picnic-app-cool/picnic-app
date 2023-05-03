import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';

class CircleMember extends Equatable {
  const CircleMember({
    required this.user,
    required this.type,
    required this.mainRole,
  });

  const CircleMember.empty()
      : user = const PublicProfile.empty(),
        type = CircleRole.director,
        mainRole = const CircleCustomRole.empty();

  final PublicProfile user;
  final CircleRole type;
  final CircleCustomRole mainRole;

  TextColor get formattedMainRoleColor =>
      mainRole.color.isNotEmpty ? TextColor.fromString(mainRole.color) : TextColor.black;

  @override
  List<Object?> get props => [
        user,
        type,
        mainRole,
      ];

  CircleMember copyWith({
    PublicProfile? user,
    CircleRole? type,
    CircleCustomRole? mainRole,
  }) {
    return CircleMember(
      user: user ?? this.user,
      type: type ?? this.type,
      mainRole: mainRole ?? this.mainRole,
    );
  }
}
