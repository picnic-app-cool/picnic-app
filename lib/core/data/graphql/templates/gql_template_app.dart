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
