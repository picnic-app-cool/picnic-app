import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/deeplink_handler/domain/model/deep_link.dart';

class FirebaseDynamicLinksSource {
  StreamController<DeepLink>? _controller;

  StreamSubscription<PendingDynamicLinkData>? _firebaseSub;

  Stream<DeepLink> get dynamicLinksOpenedApp {
    return _ensureController().stream;
  }

  StreamController<DeepLink> _ensureController() {
    return _controller ??=
        StreamController<DeepLink>.broadcast(onListen: _onStartListening, onCancel: _onCancelListening);
  }

  Future<void> _onStartListening() async {
    /// initial link is supposed to be delivered only once, later on its considered consumed by firebase, so we don't need to worry
    /// that multiple subscriptions will multiple times return this
    final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      debugLog("New initial firebase dynamic link opened app: ${initialLink.link}: $initialLink");
      _controller?.add(initialLink.toDeeplink());
    }
    _firebaseSub = FirebaseDynamicLinks.instance.onLink.listen(
      (event) {
        debugLog("New firebase dynamic link : ${event.link}: $event");
        _controller?.add(event.toDeeplink());
      },
    );
  }

  void _onCancelListening() {
    _controller = null;
    _firebaseSub?.cancel();
    _firebaseSub = null;
  }
}

extension ToDeeplink on PendingDynamicLinkData {
  DeepLink toDeeplink() => DeepLink.fromUri(link);
}
