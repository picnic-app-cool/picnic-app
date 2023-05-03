import 'package:picnic_app/features/posts/data/posts_queries.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  gqlQueryTest("voteInPollMutation", query: voteInPollMutation);

  gqlQueryTest("soundsConnectionQuery", query: soundsConnectionQuery);

  gqlQueryTest("savePostToCollectionMutation", query: savePostToCollectionMutation);

  gqlQueryTest("getLinkMetadataQuery", query: getLinkMetadataQuery);

  gqlQueryTest("createPostMutation", query: createPostMutation);

  gqlQueryTest("deletePostMutation", query: deletePostMutation);

  gqlQueryTest("getFeedPostCollectionQuery", query: getFeedPostCollectionQuery);

  gqlQueryTest("viewPostMutation", query: viewPostMutation);

  gqlQueryTest("voteInPollMutation", query: voteInPollMutation);
}
