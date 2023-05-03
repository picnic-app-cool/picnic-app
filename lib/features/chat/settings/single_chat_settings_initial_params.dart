import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SingleChatSettingsInitialParams {
  const SingleChatSettingsInitialParams(
    this.chatId,
    this.user,
  );
  final Id chatId;
  final User user;
}
