import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AvatarSelectionPresentationModel implements AvatarSelectionViewModel {
  /// Creates the initial state
  AvatarSelectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AvatarSelectionInitialParams initialParams,
  ) : selectedEmoji = initialParams.emoji;

  /// Used for the copyWith method
  AvatarSelectionPresentationModel._({
    required this.selectedEmoji,
  });

  @override
  final String selectedEmoji;

  AvatarSelectionPresentationModel copyWith({String? selectedEmoji}) {
    return AvatarSelectionPresentationModel._(
      selectedEmoji: selectedEmoji ?? this.selectedEmoji,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AvatarSelectionViewModel {
  String get selectedEmoji;
}
