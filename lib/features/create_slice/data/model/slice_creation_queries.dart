import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_slice.dart';

String get createSliceMutation => '''
mutation createSlice(\$createSliceInput: SliceInput!) {
    createSlice(createSliceInput: { payload: \$createSliceInput }) {
        ${GqlTemplate().slice}
    }
}
''';
