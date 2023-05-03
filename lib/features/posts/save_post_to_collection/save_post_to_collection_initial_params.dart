import 'package:picnic_app/features/chat/domain/model/id.dart';

class SavePostToCollectionInitialParams {
  const SavePostToCollectionInitialParams({
    required this.userId,
    required this.postId,
  });

  final Id userId;
  final Id postId;
}
