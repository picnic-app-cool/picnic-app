import 'package:picnic_app/core/data/graphql/model/connection/gql_edge.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlPageInfo {
  GqlPageInfo({
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.firstId,
    required this.lastId,
  });

  factory GqlPageInfo.fromJson(Map<String, dynamic> json) {
    return GqlPageInfo(
      hasNextPage: asT<bool>(json, 'hasNextPage'),
      hasPreviousPage: asT<bool>(json, 'hasPreviousPage'),
      firstId: json.containsKey('firstId') ? Id(asT<String>(json, 'firstId')) : const Id.empty(),
      lastId: json.containsKey('lastId') ? Id(asT<String>(json, 'lastId')) : const Id.empty(),
    );
  }

  final bool hasNextPage;
  final bool hasPreviousPage;
  final Id firstId;
  final Id lastId;

  PageInfo toDomain(List<GqlEdge> edges) => PageInfo(
        nextPageId: lastId,
        previousPageId: firstId,
        hasNextPage: hasNextPage,
        hasPreviousPage: hasPreviousPage,
      );
}
