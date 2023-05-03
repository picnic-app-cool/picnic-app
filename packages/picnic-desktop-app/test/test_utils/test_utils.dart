//ignore_for_file: unused-code, unused-files
import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_desktop_app/dependency_injection/app_component.dart';

import '../mocks/mocks.dart';
import '../../../../test/test_utils/test_utils.dart' as picnic_app;

Future<Either<F, S>> successFuture<F, S>(S result) => Future.value(success(result));

Future<Either<F, S>> failFuture<F, S>(F fail) => Future.value(failure(fail));

Future<void> prepareAppForUnitTests() async {
  await picnic_app.prepareAppForUnitTests();
  isUnitTests = true;
  resetMocktailState();
  Mocks.init();
  notImplemented = ({message, context}) => doNothing();
  overrideAppLocalizations(AppLocalizationsEn());
  await configureDependenciesForTests();
}

Future<void> configureDependenciesForTests() async {
  configureDependencies();
}

Future<void> preparePageTests(FutureOr<void> Function() testMain) async {
  overrideAppLocalizations(AppLocalizationsEn());
  await loadAppFonts();
  await prepareAppForUnitTests();
  // ignore: do_not_use_environment
  const isCi = bool.fromEnvironment('isCI');

  return AlchemistConfig.runWithConfig(
    config: const AlchemistConfig(
      platformGoldensConfig: PlatformGoldensConfig(
        // ignore: avoid_redundant_argument_values
        enabled: !isCi,
      ),
    ),
    run: () async {
      return testMain();
    },
  );
}
