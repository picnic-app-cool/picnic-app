import 'package:picnic_app/core/domain/repositories/deep_links_repository.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

class AddDeepLinkUseCase {
  const AddDeepLinkUseCase(this._deepLinksRepository);

  final DeepLinksRepository _deepLinksRepository;

  void execute({required DeepLink deepLink}) => _deepLinksRepository.triggerDeepLink(deepLink);
}
