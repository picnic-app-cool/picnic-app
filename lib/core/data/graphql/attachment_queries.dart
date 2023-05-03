import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_attachment.dart';

String get uploadAttachmentMutation => '''
  mutation uploadAttachment(\$file: AttachmentInput!) {
    uploadAttachment(file: \$file) {
      ${GqlTemplate().attachment}
    }
  }
''';
