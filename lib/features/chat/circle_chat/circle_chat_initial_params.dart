import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';

///[chat] object should be presented inside circle
class CircleChatInitialParams {
  const CircleChatInitialParams({
    required this.chat,
  });

  final Chat chat;

  MediaPickerInitialParams toMediaPickerInitialParams() => const MediaPickerInitialParams();
}
