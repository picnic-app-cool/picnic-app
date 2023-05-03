import 'dart:async';

import 'package:picnic_app/core/domain/repositories/deep_links_repository.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

class ImplDeepLinksRepository implements DeepLinksRepository {
  ImplDeepLinksRepository();

  StreamController<DeepLink>? _streamController;

  @override
  Stream<DeepLink> onDeepLinkOpen() => _ensureStreamController().stream;

  @override
  void triggerDeepLink(DeepLink deepLink) => _ensureStreamController().sink.add(deepLink);

  void _dispose() {
    _streamController?.close();
    _streamController = null;
  }

  StreamController<DeepLink> _ensureStreamController() {
    return _streamController ??= StreamController<DeepLink>.broadcast(
      onCancel: _dispose,
    );
  }
}
