import 'package:picnic_app/core/data/graphql/model/connection/gql_cursor_input.dart';
import 'package:picnic_app/features/pods/domain/model/get_recommended_circles_input.dart';

extension GqlGetRecommendedCirclesInput on GetRecommendedCirclesInput {
  Map<String, dynamic> toJson() {
    return {
      'kind': kind.value,
      'search': search,
      'cursor': cursor.toGqlCursorInput(),
      'context': {
        'appId': podId.value,
      },
    };
  }
}
