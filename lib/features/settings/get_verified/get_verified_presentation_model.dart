import 'package:picnic_app/features/settings/get_verified/get_verified_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class GetVerifiedPresentationModel implements GetVerifiedViewModel {
  /// Creates the initial state
  GetVerifiedPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    GetVerifiedInitialParams initialParams,
  );

  /// Used for the copyWith method
  GetVerifiedPresentationModel._();

  @override
  String get applyLink => "https://airtable.com/shrPbk4xxOIseMYh0";

  GetVerifiedPresentationModel copyWith() {
    return GetVerifiedPresentationModel._();
  }
}

/// Interface to expose fields used by the view (page).
abstract class GetVerifiedViewModel {
  String get applyLink;
}
