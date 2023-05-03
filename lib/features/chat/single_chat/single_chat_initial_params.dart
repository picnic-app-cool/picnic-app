import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';

class SingleChatInitialParams {
  const SingleChatInitialParams({
    required this.chat,
  });

  final BasicChat chat;

  MediaPickerInitialParams toMediaPickerInitialParams() => const MediaPickerInitialParams();
}
