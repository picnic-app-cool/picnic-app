import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
//ignore: prefer-correct-type-name
class FullscreenAttachmentPresentationModel extends FullscreenAttachmentViewModel {
  /// Creates the initial state
  FullscreenAttachmentPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FullscreenAttachmentInitialParams initialParams,
    this.currentTimeProvider,
  ) : message = initialParams.message;

  /// Used for the copyWith method
  FullscreenAttachmentPresentationModel._({
    required this.message,
    required this.currentTimeProvider,
  });

  final CurrentTimeProvider currentTimeProvider;

  @override
  final ChatMessage message;

  @override
  DateTime get now => currentTimeProvider.currentTime;

  FullscreenAttachmentPresentationModel copyWith({
    ChatMessage? message,
    CurrentTimeProvider? currentTimeProvider,
  }) {
    return FullscreenAttachmentPresentationModel._(
      message: message ?? this.message,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FullscreenAttachmentViewModel {
  ChatMessage get message;

  DateTime get now;
}
