import 'package:picnic_app/core/data/graphql/model/gql_collection_counter.dart';
import 'package:picnic_app/core/data/graphql/model/gql_post.dart';
import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/collection_counter.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlCollection {
  const GqlCollection({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.isPublic,
    required this.createdAt,
    required this.counters,
    required this.previewPosts,
  });

  factory GqlCollection.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlCollection(
      id: asT<String>(json, 'id'),
      title: asT<String>(json, 'title'),
      description: asT<String>(json, 'description'),
      owner: GqlPublicProfile.fromJson(
        asT<Map<String, dynamic>>(json, 'owner'),
      ),
      isPublic: asT<bool>(json, 'isPublic'),
      createdAt: asT<String>(json, 'createdAt'),
      counters: GqlCollectionCounter.fromJson(
        asT<Map<String, dynamic>>(json, 'counters'),
      ),
      previewPosts: asList<GqlPost>(
        json,
        'previewPosts',
        (element) => GqlPost.fromJson(element),
      ),
    );
  }

  final String? id;
  final String? title;
  final String? description;
  final GqlPublicProfile? owner;
  final bool? isPublic;
  final String? createdAt;
  final GqlCollectionCounter? counters;
  final List<GqlPost>? previewPosts;

  Collection toDomain(UserStore userStore) => Collection(
        id: Id(id ?? ''),
        title: title ?? '',
        description: description ?? '',
        owner: owner?.toDomain(userStore) ?? const PublicProfile.empty(),
        isPublic: isPublic ?? false,
        createdAt: createdAt ?? '',
        counters: counters?.toDomain() ?? const CollectionCounter.empty(),
        previewPosts: previewPosts?.map((e) => e.toDomain(userStore)).toList() ?? const [],
      );
}
