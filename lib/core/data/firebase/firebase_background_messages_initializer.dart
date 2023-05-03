import 'dart:async';

import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
import 'package:picnic_app/features/push_notifications/data/firebase_messaging_wrapper.dart';

class FirebaseBackgroundMessagesInitializer implements LibraryInitializer {
  FirebaseBackgroundMessagesInitializer(
    this._firebaseProvider,
  );

  final FirebaseProvider _firebaseProvider;

  @override
  Future<void> init() async {
    _firebaseProvider.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}
