import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';

class GqlChatSettings {
  GqlChatSettings({
    required this.isMuted,
  });

  factory GqlChatSettings.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlChatSettings(
      isMuted: asT<bool>(json, 'isMuted'),
    );
  }

  final bool isMuted;

  ChatSettings toDomain() => ChatSettings(
        isMuted: isMuted,
      );
}
