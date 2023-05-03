import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SliceSettingsPresentationModel implements SliceSettingsViewModel {
  /// Creates the initial state
  SliceSettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SliceSettingsInitialParams initialParams,
  )   : circle = initialParams.circle,
        slice = initialParams.slice,
        sliceSettings = const SliceSettings.empty();

  /// Used for the copyWith method
  SliceSettingsPresentationModel._({
    required this.circle,
    required this.slice,
    required this.sliceSettings,
  });

  final Circle circle;
  final Slice slice;

  final SliceSettings sliceSettings;

  @override
  String get circleName => circle.name;

  @override
  String get sliceName => slice.name;

  @override
  int get membersCount => circle.membersCount;

  @override
  String get circleEmoji => circle.emoji;

  @override
  String get circleImage => circle.imageFile;

  @override
  bool get isMuted => sliceSettings.isMuted;

  @override
  bool get isJoined => slice.iJoined;

  @override
  bool get canEditSlice => circle.circleRole == CircleRole.director || circle.circleRole == CircleRole.moderator;

  SliceSettingsPresentationModel byUpdatingSlice(Slice slice) =>
      copyWith(slice: slice.copyWith(iJoined: slice.iJoined));

  SliceSettingsPresentationModel copyWith({
    Circle? circle,
    Slice? slice,
    SliceSettings? sliceSettings,
  }) {
    return SliceSettingsPresentationModel._(
      circle: circle ?? this.circle,
      slice: slice ?? this.slice,
      sliceSettings: sliceSettings ?? this.sliceSettings,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SliceSettingsViewModel {
  String get circleName;

  String get sliceName;

  int get membersCount;

  String get circleEmoji;

  String get circleImage;

  bool get isMuted;

  bool get isJoined;

  bool get canEditSlice;
}
