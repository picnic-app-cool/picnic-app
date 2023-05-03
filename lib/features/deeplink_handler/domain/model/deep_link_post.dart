import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

class DeepLinkPost extends Equatable implements DeepLink {
  const DeepLinkPost({
    required this.postId,
  });

  const DeepLinkPost.empty() : postId = const Id.empty();

  factory DeepLinkPost.fromUri(Uri link) => DeepLinkPost(
        postId: Id(link.pathSegments[1]),
      );

  final Id postId;

  @override
  DeepLinkType get type => DeepLinkType.post;

  @override
  bool get requiresAuthenticatedUser => true;

  @override
  List<Object?> get props => [type];

  DeepLinkPost copyWith({
    Id? postId,
  }) {
    return DeepLinkPost(
      postId: postId ?? this.postId,
    );
  }
}
