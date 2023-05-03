import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_link_metadata.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_sound.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get savePostToCollectionMutation => """
mutation savePostStatus(\$postId: ID!, \$saveStatus: Boolean!) {
    savePostStatus(postId:\$postId ,saveStatus: \$saveStatus){
        ${GqlTemplate().successPayload}
    }
}
""";

String get getLinkMetadataQuery => """
query linkMetaData(\$link: String!){
    linkMetaData(link: \$link) {
        data {
          ${GqlTemplate().linkMetadata}
        }
    }
}
""";

const String reactPostMutation = r'''
mutation ($id: String!, $react: Boolean!) {
    setReactPost(data: {
        id: $id
        react: $react
        reaction: ":heart:"
    }){
        success
    }
}
''';

String get createPostMutation => """
mutation createPost(\$data: CreatePostInput!){
  createPost(data: \$data){
      ${GqlTemplate().post}
  }
}
""";

String get deletePostMutation => """
mutation deletePost(\$postId: String!) {
    deletePost(data:{id:\$postId}){
        ${GqlTemplate().successPayload}
    }
}
""";

String get deletePostsMutation => """
mutation deletePosts(\$ids: [String!]!) {
    deletePosts(data:{ids:\$ids}){
        ${GqlTemplate().successPayload}
    }
}
""";

String get getFeedPostCollectionQuery => """
query feedPostsConnection(\$feedId: String!, \$cursor: CursorInput!){
   feedPostsConnection(feedId:\$feedId, cursor:\$cursor){
            pageInfo{
                hasNextPage
                lastId
            }
            edges{
                cursorId
                node {
                 ${GqlTemplate().post}
                }
            }
    }
}
""";

String get soundsConnectionQuery => """
    query(\$searchQuery: String, \$cursor: CursorInput) {
        soundsConnection(searchQuery: \$searchQuery, cursor: \$cursor) {
          ${GqlTemplate().connection(nodeTemplate: GqlTemplate().sound)}
        }
    }
""";

String get viewPostMutation => """
mutation viewPost(\$postId: ID!) {
    viewPost(id: \$postId){
        ${GqlTemplate().successPayload}
    }
}
""";

String get sharePostMutation => """
mutation sharePost(\$postId: ID!) {
    sharePost(postId: \$postId){
        ${GqlTemplate().successPayload}
    }
}
""";

String get voteInPollMutation => """
mutation voteInPoll(\$variantId: ID!, \$postId: ID!) {
    voteInPoll(data:{variantId: \$variantId, postId: \$postId}){
        ${GqlTemplate().successPayload}
    }
}
""";

String get getPostByIdQuery => """
query(\$postId: String!){
        getPost(postId: \$postId){   
            ${GqlTemplate().post}
        }
    }
""";
