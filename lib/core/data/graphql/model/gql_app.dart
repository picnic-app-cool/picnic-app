import 'package:picnic_app/core/data/graphql/model/gql_app_owner.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app_permission.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app_subscription.dart';
import 'package:picnic_app/core/data/graphql/model/gql_app_tag.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_owner.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GqlApp {
  const GqlApp({
    required this.id,
    required this.url,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.appTags,
    required this.appPermissions,
    required this.appSubscriptions,
    required this.owner,
    required this.createdAt,
    required this.score,
  });

  //ignore: long-method
  factory GqlApp.fromJson(Map<String, dynamic>? json) {
    List<GqlAppPermission>? appPermissions;
    List<GqlAppSubscription>? appSubscriptions;
    List<GqlAppTag>? appTags;
    GqlAppOwner? owner;
    if (json != null && json['permissions'] != null) {
      appPermissions =
          (json['permissions'] as List).map((e) => GqlAppPermission.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (json != null && json['subscriptions'] != null) {
      appSubscriptions =
          (json['subscriptions'] as List).map((e) => GqlAppSubscription.fromJson(e as Map<String, dynamic>)).toList();
    }
    if (json != null && json['owner'] != null) {
      owner = GqlAppOwner.fromJson((json['owner'] as Map).cast());
    }
    if (json != null && json['tags'] != null) {
      appTags = (json['tags'] as List).map((e) => GqlAppTag.fromJson(e as Map<String, dynamic>)).toList();
    }
    return GqlApp(
      id: asT<String>(json, 'id'),
      url: asT<String>(json, 'url'),
      name: asT<String>(json, 'name'),
      imageUrl: asT<String>(json, 'imageUrl'),
      description: asT<String>(json, 'description'),
      appTags: appTags ?? [],
      appPermissions: appPermissions ?? [],
      appSubscriptions: appSubscriptions ?? [],
      owner: owner,
      createdAt: asT<String>(json, 'createdAt'),
      score: asT<int>(json, 'score'),
    );
  }

  final String id;
  final String url;
  final String name;
  final String imageUrl;
  final String description;
  final List<GqlAppTag> appTags;
  final List<GqlAppPermission> appPermissions;
  final List<GqlAppSubscription> appSubscriptions;
  final GqlAppOwner? owner;
  final String createdAt;
  final int score;

  PodApp toDomain() => PodApp(
        id: Id(id),
        url: url,
        name: name,
        imageUrl: imageUrl,
        description: description,
        appTags: appTags.map((e) => e.toDomain()).toList(),
        appPermissions: appPermissions.map((e) => e.toDomain()).toList(),
        appSubscriptions: appSubscriptions.map((e) => e.toDomain()).toList(),
        owner: owner?.toDomain() ?? const AppOwner.empty(),
        createdAt: createdAt,
        score: score,
      );
}
