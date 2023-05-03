import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_chat.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_circle.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_election.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_general.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_post.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_profile.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_type.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link_user_seeds.dart';

abstract class DeepLink {
  factory DeepLink.chat({required Id chatId}) => DeepLinkChat(chatId: chatId);

  factory DeepLink.profile({required Id userId}) => const DeepLinkProfile.empty().copyWith(userId: userId);

  factory DeepLink.circle({required Id circleId}) => const DeepLinkCircle.empty().copyWith(circleId: circleId);

  factory DeepLink.election({required Id circleId}) => DeepLinkElection(circleId: circleId);

  factory DeepLink.post({required Id postId}) => DeepLinkPost(postId: postId);

  factory DeepLink.userSeeds() => const DeepLinkUserSeeds();

  factory DeepLink.general() => const DeepLinkGeneral();

  factory DeepLink.fromUri(Uri link) {
    final firstPath = link.pathSegments.first.toLowerCase().trim();
    switch (firstPath) {
      case 'circle':
        return DeepLinkCircle.fromUriId(link);
      case 'c':
        return DeepLinkCircle.fromUriCircleName(link);
      case 'election':
        return DeepLinkElection.fromUri(link);
      case 'profile':
      case 'user':
        return DeepLinkProfile.fromUriId(link);
      case 'u':
        return DeepLinkProfile.fromUriUsername(link);
      case 'p':
      case 'post':
        return DeepLinkPost.fromUri(link);
    }
    return DeepLink.general();
  }

  DeepLinkType get type;

  bool get requiresAuthenticatedUser;
}

extension DeepLinkWhen on DeepLink {
  // ignore: long-parameter-list
  void when({
    required void Function(DeepLinkChat deepLink) onChatDeepLink,
    required void Function(DeepLinkProfile deepLink) onProfileDeepLink,
    required void Function(DeepLinkCircle deepLink) onCircleDeepLink,
    required void Function(DeepLinkPost deepLink) onPostDeepLink,
    required void Function(DeepLinkUserSeeds deepLink) onUserSeeds,
    required void Function(DeepLinkElection deepLink) onElection,
  }) {
    switch (type) {
      case DeepLinkType.general:
        break;
      case DeepLinkType.profile:
        return onProfileDeepLink(this as DeepLinkProfile);
      case DeepLinkType.chat:
        return onChatDeepLink(this as DeepLinkChat);
      case DeepLinkType.circle:
        return onCircleDeepLink(this as DeepLinkCircle);
      case DeepLinkType.post:
        return onPostDeepLink(this as DeepLinkPost);
      case DeepLinkType.userSeeds:
        return onUserSeeds(this as DeepLinkUserSeeds);
      case DeepLinkType.election:
        return onElection(this as DeepLinkElection);
    }
  }
}
