import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SingleChatInput extends Equatable {
  const SingleChatInput({
    required this.userIds,
  });

  SingleChatInput.empty() : userIds = List.empty();

  final List<Id> userIds;

  @override
  List<Object> get props => [
        userIds,
      ];

  SingleChatInput copyWith({
    List<Id>? userIds,
  }) {
    return SingleChatInput(
      userIds: userIds ?? this.userIds,
    );
  }
}
