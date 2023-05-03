import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SavePostInput extends Equatable {
  const SavePostInput({
    required this.postId,
    required this.save,
  }) :
        // The collection ID needs to come from backend, or needs to be created when there is none
        // In case there is already a collection, the collection should be fetched as soon as the app
        // starts so that we can know at this place which collection save this post into
        // TODO: Implement a repository function for retrieving a collection if there is one [GS-1801]
        collectionId = const Id.empty();

  const SavePostInput.empty()
      : postId = const Id.empty(),
        collectionId = const Id.empty(),
        save = false;

  final Id postId;
  final Id collectionId;
  final bool save;

  @override
  List<Object> get props => [
        postId,
        collectionId,
        save,
      ];

  SavePostInput copyWith({
    Id? postId,
    bool? save,
  }) {
    return SavePostInput(
      postId: postId ?? this.postId,
      save: save ?? this.save,
    );
  }
}
