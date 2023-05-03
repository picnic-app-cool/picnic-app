import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetMembersInput extends Equatable {
  const GetMembersInput({
    required this.circleId,
    required this.cursor,
    this.roles = const [],
    this.searchQuery = '',
    this.onlyBannedUsers = false,
  });

  const GetMembersInput.empty()
      : circleId = const Id.empty(),
        cursor = const Cursor.firstPage(),
        roles = const [],
        searchQuery = '',
        onlyBannedUsers = false;

  final Id circleId;
  final Cursor cursor;
  final List<CircleRole> roles;
  final String searchQuery;
  final bool onlyBannedUsers;

  @override
  List<Object> get props => [
        circleId,
        cursor,
        roles,
        searchQuery,
        onlyBannedUsers,
      ];

  GetMembersInput copyWith({
    Id? circleId,
    Cursor? cursor,
    List<CircleRole>? roles,
    String? searchQuery,
    bool? onlyBannedUsers,
  }) {
    return GetMembersInput(
      circleId: circleId ?? this.circleId,
      cursor: cursor ?? this.cursor,
      roles: roles ?? this.roles,
      searchQuery: searchQuery ?? this.searchQuery,
      onlyBannedUsers: onlyBannedUsers ?? this.onlyBannedUsers,
    );
  }
}
