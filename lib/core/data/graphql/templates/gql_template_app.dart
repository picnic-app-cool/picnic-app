import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateApp on GqlTemplate {
  String get app => '''
      id
      url
      name
      imageUrl
      description
      tags {
        $appTag
      }
      permissions {
        $appPermission
      }
      subscriptions {
        $appSubscription
      }
      owner {
        $appOwner
      }
      createdAt
      score 
      counters {
        $counters
      }
      userContext {
        $userContext
      }
    ''';

  String get appTag => '''
      id
      name
    ''';

  String get appPermission => '''
      id
      dxName
      uxName
      description
      descriptors
    ''';

  String get appSubscription => '''
      id
      descriptor
    ''';

  String get appOwner => '''
      id
      name
    ''';

  String get counters => '''
      saves
      circles
      upvotes
      reviews
      avgRating
    ''';

  String get userContext => '''
      usedAt
      savedAt
      upvotedAt
    ''';
}
