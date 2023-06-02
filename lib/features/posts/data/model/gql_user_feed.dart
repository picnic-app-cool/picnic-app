import 'package:picnic_app/core/data/graphql/model/connection/gql_edge.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GqlUserFeed {
  const GqlUserFeed({
    required this.edges,
  });

  factory GqlUserFeed.fromJson(Map<String, dynamic> json) => GqlUserFeed(
        edges: asList(
          json,
          'edges',
          GqlEdge.fromJson,
        ), //
      );

  final List<GqlEdge> edges;

  List<Post> toDomain({
    required UserStore userStore,
  }) =>
      edges
          .map(
            (edge) => GqlPost.fromJson(edge.node).toDomain(userStore),
          )
          .toList();
}
