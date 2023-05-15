import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/app_owner.dart';
import 'package:picnic_app/core/domain/model/app_permission.dart';
import 'package:picnic_app/core/domain/model/app_subscription.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class PodApp extends Equatable {
  const PodApp({
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

  const PodApp.empty()
      : id = const Id.empty(),
        url = '',
        name = '',
        imageUrl = '',
        description = '',
        appTags = const [],
        appPermissions = const [],
        appSubscriptions = const [],
        owner = const AppOwner.empty(),
        createdAt = '',
        score = 0;

  final Id id;
  final String url;
  final String name;
  final String imageUrl;
  final String description;
  final List<AppTag> appTags;
  final List<AppPermission> appPermissions;
  final List<AppSubscription> appSubscriptions;
  final AppOwner owner;
  final String createdAt;
  final int score;

  @override
  List<Object> get props => [
        id,
        url,
        name,
        imageUrl,
        description,
        appTags,
        appPermissions,
        appSubscriptions,
        owner,
        createdAt,
        score,
      ];

  PodApp copyWith({
    Id? id,
    String? url,
    String? name,
    String? imageUrl,
    String? description,
    List<AppTag>? appTags,
    List<AppPermission>? appPermissions,
    List<AppSubscription>? appSubscriptions,
    AppOwner? owner,
    String? createdAt,
    int? score,
  }) {
    return PodApp(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      appTags: appTags ?? this.appTags,
      appPermissions: appPermissions ?? this.appPermissions,
      appSubscriptions: appSubscriptions ?? this.appSubscriptions,
      owner: owner ?? this.owner,
      createdAt: createdAt ?? this.createdAt,
      score: score ?? this.score,
    );
  }
}
