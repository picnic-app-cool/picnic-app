import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/collection_counter.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class Collection extends Equatable {
  const Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.owner,
    required this.isPublic,
    required this.createdAt,
    required this.counters,
    required this.previewPosts,
  });

  const Collection.empty()
      : id = const Id(''),
        title = '',
        description = '',
        owner = const PublicProfile.empty(),
        isPublic = false,
        createdAt = '',
        counters = const CollectionCounter.empty(),
        previewPosts = const [];

  final Id id;
  final String title;
  final String description;
  final PublicProfile owner;
  final bool isPublic;
  final String createdAt;
  final CollectionCounter counters;
  final List<Post> previewPosts;

  Id get ownerId => owner.id;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        owner,
        isPublic,
        createdAt,
        counters,
        previewPosts,
      ];

  List<ImageUrl> get thumbnails => previewPosts
      .map(
        (e) => e.content.when(
          imagePostContent: (value) => value.imageUrl,
          linkPostContent: (value) => ImageUrl(Assets.images.textOrLinkPostPlaceholder.path),
          pollPostContent: (value) => ImageUrl(Assets.images.pollPostPlaceholder.path),
          textPostContent: (value) => ImageUrl(Assets.images.textOrLinkPostPlaceholder.path),
          unknownContent: () => const ImageUrl.empty(),
          videoPostContent: (value) => value.thumbnailUrl,
        ),
      )
      .toList();

  Collection copyWith({
    Id? id,
    String? title,
    String? description,
    PublicProfile? owner,
    bool? isPublic,
    String? createdAt,
    CollectionCounter? counters,
    List<Post>? previewPosts,
  }) =>
      Collection(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        isPublic: isPublic ?? this.isPublic,
        createdAt: createdAt ?? this.createdAt,
        counters: counters ?? this.counters,
        previewPosts: previewPosts ?? this.previewPosts,
      );
}
