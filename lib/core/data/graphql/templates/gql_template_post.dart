import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_link_metadata.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_minimal_public_profile.dart';

extension GqlTemplatePost on GqlTemplate {
  String get post => '''
          id
          createdAt
          shareLink
          title
          type
          textContent{
              text
              more
              color
          }
          linkContent{
              url
              linkMetaData {
                ${GqlTemplate().linkMetadata}
              }
          }
          imageContent{
              text
              url
          }
          videoContent{
              url
              thumbnailUrl
              duration
              text
          }
          pollContent{
              votedAnswer
              question
              answers{
                  id
                  imageUrl
                  votesCount
              }
              votesTotal
          }
          viewsCount
          sharesCount
          savesCount
          commentsCount
          likesCount
          iReacted
          iSaved
          author {
            ${GqlTemplate().basicPublicProfile}
          }
          circle {
            ${GqlTemplate().basicCircle}
          }
  ''';
}
