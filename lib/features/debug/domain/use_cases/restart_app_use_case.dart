//ignore_for_file: forbidden_import_in_domain
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/domain/model/restart_app_failure.dart';
import 'package:picnic_app/navigation/app_navigator.dart';

class RestartAppUseCase {
  const RestartAppUseCase();

  Future<Either<RestartAppFailure, Unit>> execute() async {
    try {
      await getIt.reset();
      final context = AppNavigator.currentContext;
      await Hive.close();
      // ignore: invalid_use_of_visible_for_testing_member
      Hive.resetAdapters();
      // one of the allowed use cases to access navigator key directly, thus ignoring the warning
      //ignore: invalid_use_of_protected_member
      AppNavigator.navigatorKey = GlobalKey();
      AppNavigator.nestedNavigatorKey = null;
      // we're sure the context is available, thus ignoring the warning
      //ignore: use_build_context_synchronously
      Phoenix.rebirth(context);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(RestartAppFailure.unknown(ex));
    }
    return success(unit);
  }
}
