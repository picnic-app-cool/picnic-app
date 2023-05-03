import 'dart:async';

import 'package:picnic_app/core/data/firebase/firebase_dynamic_links_source.dart';
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
import 'package:picnic_app/core/domain/use_cases/add_deeplink_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/picnic_app.dart';

class FirebaseDynamicLinksInitializer implements LibraryInitializer {
  FirebaseDynamicLinksInitializer(this.dynamicLinksSource);

  final FirebaseDynamicLinksSource dynamicLinksSource;

  @override
  Future<void> init() async {
    //unawaited on purpose, since we want to wait for entire app to initialize first before listening
    unawaited(_triggerDynamicLinksListening());
  }

  Future<void> _triggerDynamicLinksListening() async {
    await PicnicApp.ensureAppInitialized();

    ///we're using getIt, because we want to make sure entire app is initialized before we create AddDeeplinkUseCase
    final addDeeplinkUseCase = getIt<AddDeepLinkUseCase>();
    dynamicLinksSource.dynamicLinksOpenedApp.listen((deeplink) {
      addDeeplinkUseCase.execute(deepLink: deeplink);
    });
  }
}
