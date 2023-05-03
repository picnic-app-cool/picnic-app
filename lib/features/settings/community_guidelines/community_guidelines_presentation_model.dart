import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CommunityGuidelinesPresentationModel implements CommunityGuidelinesViewModel {
  /// Creates the initial state
  CommunityGuidelinesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CommunityGuidelinesInitialParams initialParams,
  );

  /// Used for the copyWith method
  CommunityGuidelinesPresentationModel._();

  CommunityGuidelinesPresentationModel copyWith() {
    return CommunityGuidelinesPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class CommunityGuidelinesViewModel {}
