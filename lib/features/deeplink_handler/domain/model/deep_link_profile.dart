import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';

//ignore: missing_empty_constructor, missing_copy_with_method
class DeepLinkProfile extends Equatable implements DeepLink {
  const DeepLinkProfile({
    required this.userId,
    required this.username,
  });

  const DeepLinkProfile.empty()
      : userId = const Id.empty(),
        username = '';

  factory DeepLinkProfile.fromUriId(Uri link) => DeepLinkProfile(
        userId: Id(link.pathSegments[1]),
        username: '',
      );

  factory DeepLinkProfile.fromUriUsername(Uri link) => DeepLinkProfile(
        userId: const Id.empty(),
        username: link.pathSegments[1],
      );

  final Id userId;
  final String username;

  @override
  DeepLinkType get type => DeepLinkType.profile;

  @override
  bool get requiresAuthenticatedUser => true;

  @override
  List<Object?> get props => [
        userId,
        username,
        type,
      ];

  DeepLinkProfile copyWith({
    Id? userId,
    String? username,
  }) {
    return DeepLinkProfile(
      userId: userId ?? this.userId,
      username: username ?? this.username,
    );
  }
}
