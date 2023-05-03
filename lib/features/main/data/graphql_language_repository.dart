import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/main/data/language_queries.dart';
import 'package:picnic_app/features/main/data/model/gql_language_json.dart';
import 'package:picnic_app/features/main/domain/repositories/language_repository.dart';

class GraphqlLanguageRepository implements LanguageRepository {
  GraphqlLanguageRepository(
    this._gqlClient,
  );

  final GraphQLClient _gqlClient;

  @override
  Future<Either<GetLanguageFailure, List<Language>>> getLanguages() => _gqlClient
      .query(
        document: getLanguagesListQuery,
        variables: {"filter": "ENABLED"},
        parseData: (json) {
          final data = json['listLanguages'] as List;
          return data.map((e) => GqlLanguageJson.fromJson(e as Map<String, dynamic>));
        },
      )
      .mapFailure(GetLanguageFailure.unknown)
      .mapSuccess(
        (connection) => connection.map((e) => e.toDomain()).toList(),
      );
}
