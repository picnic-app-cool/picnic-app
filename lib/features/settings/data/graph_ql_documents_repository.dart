import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/data/model/gql_delete_account_reasons_list_json.dart';
import 'package:picnic_app/features/settings/data/settings_queries.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/model/get_delete_account_reasons_failure.dart';
import 'package:picnic_app/features/settings/domain/repositories/documents_repository.dart';

class GraphQlDocumentsRepository implements DocumentsRepository {
  const GraphQlDocumentsRepository(this._gqlClient);

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetDeleteAccountReasonsFailure, List<DeleteAccountReason>>> getDeleteAccountReasons({
    required DocumentEntityType documentEntityType,
  }) async {
    return _gqlClient
        .query(
          document: getDocumentByKey,
          variables: {
            'key': documentEntityType.stringVal,
          },
          parseData: (json) {
            final data = asT<String>(json, 'documentGet');
            final decodedList = fromJsonMethod(data);

            return GqlDeleteAccountReasonsListJson.fromJson(decodedList);
          },
        )
        .mapFailure(GetDeleteAccountReasonsFailure.unknown)
        .mapSuccess(
          (deleteAccountReasons) => deleteAccountReasons.toDomain(),
        );
  }
}
