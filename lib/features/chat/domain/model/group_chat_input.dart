import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GroupChatInput extends Equatable {
  const GroupChatInput({
    required this.name,
    required this.userIds,
  });

  GroupChatInput.empty()
      : name = '',
        userIds = List.empty();

  final String name;
  final List<Id> userIds;

  @override
  List<Object> get props => [
        name,
        userIds,
      ];

  GroupChatInput copyWith({
    String? name,
    List<Id>? userIds,
  }) {
    return GroupChatInput(
      name: name ?? this.name,
      userIds: userIds ?? this.userIds,
    );
  }
}
