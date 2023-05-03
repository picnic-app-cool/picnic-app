import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AddBlackListWordPresentationModel implements AddBlackListWordViewModel {
  /// Creates the initial state
  AddBlackListWordPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AddBlackListWordInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        editedWord = initialParams.word,
        newWord = initialParams.word;

  /// Used for the copyWith method
  AddBlackListWordPresentationModel._({
    required this.circleId,
    required this.editedWord,
    required this.newWord,
  });

  @override
  final Id circleId;

  @override
  final String editedWord;

  @override
  final String newWord;

  AddBlackListWordPresentationModel copyWith({
    Id? circleId,
    String? editedWord,
    String? newWord,
  }) {
    return AddBlackListWordPresentationModel._(
      circleId: circleId ?? this.circleId,
      editedWord: editedWord ?? this.editedWord,
      newWord: newWord ?? this.newWord,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AddBlackListWordViewModel {
  Id get circleId;

  String get editedWord;

  String get newWord;
}
