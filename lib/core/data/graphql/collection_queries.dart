import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_collection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getCollectionsQuery => """
query (\$userId: ID!, \$cursor: CursorInput!, \$withPreviewPosts: Boolean!, \$returnSavedPostsCollection: Boolean!) {
  collectionsConnection(userId: \$userId, cursor: \$cursor, withPreviewPosts: \$withPreviewPosts, returnSavedPostsCollection: \$returnSavedPostsCollection) {
    ${GqlTemplate().connection(nodeTemplate: GqlTemplate().collectionWithPreviewPosts)}
  }
}
""";

String removeCollectionPosts = """
mutation deletePostsFromCollection(\$collectionId:ID!, \$postIds: [ID!], \$unsave: Boolean! ) {
    deletePostsFromCollection(collectionId :\$collectionId, postIds :\$postIds, unsave: \$unsave) {
      ${GqlTemplate().successPayload}
  }
}
""";

String addPostToCollectionQuery = """
mutation addPostToCollection(\$collectionId:ID!, \$postId:ID!) {
    addPostToCollection(collectionId :\$collectionId, postId :\$postId) {
      ${GqlTemplate().successPayload}
  }
}
""";

String deleteCollectionQuery = """
mutation deleteCollection(\$collectionId: ID!) {
  deleteCollection(collectionId: \$collectionId) {
        ${GqlTemplate().successPayload}
}
}
  """;

String createCollectionMutation = """
mutation createCollection(\$createCollectionInput: CreateCollectionInput!) {
  createCollection(collection: \$createCollectionInput) {
        ${GqlTemplate().collection}
}
}
  """;

String get collectionPostsQuery => """
query (\$collectionId: ID!, \$cursor: CursorInput!) {
  collectionPostsConnection(collectionId: \$collectionId, cursor: \$cursor) {
      ${GqlTemplate().connection(nodeTemplate: GqlTemplate().post)}
  }
}
""";
