import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_circle_config.dart';

String getDefaultCircleConfigQuery = """
query {
  defaultCircleConfigOptions{
      options {
      ${GqlTemplate().circleConfig}
			}
  }
}
""";
