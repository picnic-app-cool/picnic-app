import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AchievementsPresentationModel implements AchievementsViewModel {
  /// Creates the initial state
  AchievementsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AchievementsInitialParams initialParams,
  );

  /// Used for the copyWith method
  AchievementsPresentationModel._();

  AchievementsPresentationModel copyWith() {
    return AchievementsPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class AchievementsViewModel {}
