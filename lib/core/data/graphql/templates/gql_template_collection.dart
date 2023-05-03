import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_post.dart';

extension GqlTemplateCollection on GqlTemplate {
  String get collection => '''
id
title
description
owner {
  $ownerProfile
}
''';

  String get collectionWithPreviewPosts => '''
id
title
description
owner {
  $ownerProfile
}
isPublic
createdAt
counters {
    posts
}
previewPosts {
  $post
}
''';

  String get ownerProfile => '''
id
username
''';
}
