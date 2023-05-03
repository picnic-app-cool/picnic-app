import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleChatSettingsPresentationModel implements CircleChatSettingsViewModel {
  /// Creates the initial state
  CircleChatSettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleChatSettingsInitialParams initialParams,
  )   : circle = initialParams.circle,
        chatSettings = const ChatSettings.empty(),
        onCircleChanged = initialParams.onCircleChanged;

  /// Used for the copyWith method
  CircleChatSettingsPresentationModel._({
    required this.circle,
    required this.chatSettings,
    required this.onCircleChanged,
  });

  final Circle circle;

  final ChatSettings chatSettings;

  final ValueChanged<Circle>? onCircleChanged;

  @override
  String get circleName => circle.name;

  @override
  int get membersCount => circle.membersCount;

  @override
  String get circleEmoji => circle.emoji;

  @override
  String get circleImage => circle.imageFile;

  @override
  bool get isMuted => chatSettings.isMuted;

  @override
  bool get isJoined => circle.iJoined;

  CircleChatSettingsPresentationModel byUpdatingCircle(Circle circle) =>
      copyWith(circle: circle.copyWith(iJoined: circle.iJoined));

  CircleChatSettingsPresentationModel copyWith({
    Circle? circle,
    ChatSettings? chatSettings,
    ValueChanged<Circle>? onCircleChanged,
  }) {
    if (circle != null) {
      (onCircleChanged ?? this.onCircleChanged)?.call(circle);
    }
    return CircleChatSettingsPresentationModel._(
      circle: circle ?? this.circle,
      chatSettings: chatSettings ?? this.chatSettings,
      onCircleChanged: onCircleChanged ?? this.onCircleChanged,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleChatSettingsViewModel {
  String get circleName;

  int get membersCount;

  String get circleEmoji;

  String get circleImage;

  bool get isMuted;

  bool get isJoined;
}
