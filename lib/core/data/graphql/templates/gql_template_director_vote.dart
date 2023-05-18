import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';

extension GqlTemplateDirectorVote on GqlTemplate {
  String get directorVote => '''
    circleId
    candidateId
    candidate {
      ${GqlTemplate().voteCandidate}
    }
''';
}
