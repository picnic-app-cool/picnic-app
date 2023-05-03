import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CreateNewCollectionPresentationModel implements CreateNewCollectionViewModel {
  /// Creates the initial state
  CreateNewCollectionPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CreateNewCollectionInitialParams initialParams,
  ) : collectionName = '';

  /// Used for the copyWith method
  CreateNewCollectionPresentationModel._({
    required this.collectionName,
  });

  @override
  final String collectionName;

  CreateNewCollectionPresentationModel copyWith({
    String? collectionName,
  }) {
    return CreateNewCollectionPresentationModel._(
      collectionName: collectionName ?? this.collectionName,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CreateNewCollectionViewModel {
  String get collectionName;
}
