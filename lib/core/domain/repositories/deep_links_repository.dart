import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

abstract class DeepLinksRepository {
  Stream<DeepLink> onDeepLinkOpen();

  void triggerDeepLink(DeepLink deepLink);
}
