import 'package:picnic_app/core/domain/repositories/deep_links_repository.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

class ListenToDeepLinksUseCase {
  const ListenToDeepLinksUseCase(this._deepLinksRepository);

  final DeepLinksRepository _deepLinksRepository;

  Stream<DeepLink> execute() => _deepLinksRepository.onDeepLinkOpen();
}
