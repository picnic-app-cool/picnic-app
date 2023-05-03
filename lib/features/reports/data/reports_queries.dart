import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_report.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getReportReasonsQuery => """
query reportReasons(\$entity: ReportEntity!) {
  reportReasons(entity: \$entity) {
    ${GqlTemplate().reportReason}
  }
}
""";

String get createGlobalReportMutation => """
mutation createReport(\$info: CreateReportInput!) {
  createReport(info: \$info) {
    ${GqlTemplate().successPayload}
  }
}
""";

String get createCircleReportMutation => """
mutation report(\$reportInput: ReportInput!) {
  report(reportInput: \$reportInput) {
    ${GqlTemplate().successPayload}
  }
}
""";
