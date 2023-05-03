import 'package:picnic_app/core/data/graphql/model/connection/gql_edge.dart';
import 'package:picnic_app/core/data/graphql/model/connection/gql_page_info.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';

/// representation of graphql connection. Connections allow to represent paginated lists in GraphQL
/// https://www.apollographql.com/blog/graphql/explaining-graphql-connections/
///
class GqlConnection {
  const GqlConnection({
    required this.pageInfo,
    required this.edges,
  });

  factory GqlConnection.fromJson(Map<String, dynamic> json) => GqlConnection(
        pageInfo: GqlPageInfo.fromJson(
          asT<Map<String, dynamic>>(json, 'pageInfo'),
        ),
        //ignore: strict_raw_type
        edges: asList(
          json,
          'edges',
          GqlEdge.fromJson,
        ), //
      );

  final GqlPageInfo pageInfo;
  final List<GqlEdge> edges;

  PaginatedList<T> toDomain<T>({
    required T Function(Map<String, dynamic>) nodeMapper,
  }) =>
      PaginatedList(
        pageInfo: pageInfo.toDomain(edges),
        items: edges.map((edge) => nodeMapper(edge.node)).toList(),
      );

  PaginatedList<T> toDomainWithRelations<T>({
    required T Function(Map<String, dynamic> node, Map<String, dynamic> relations) nodeMapper,
  }) =>
      PaginatedList(
        pageInfo: pageInfo.toDomain(edges),
        items: edges.map((edge) => nodeMapper(edge.node, edge.relations)).toList(),
      );
}
