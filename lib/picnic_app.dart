import 'dart:async';

import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';
import 'package:picnic_app/features/app_init/force_log_out_observer/force_log_out_observer.dart';
import 'package:picnic_app/features/app_init/force_log_out_observer/force_log_out_observer_presenter.dart';
import 'package:picnic_app/features/connection_status/connection_status_handler_widget.dart';
import 'package:picnic_app/features/debug/debug/debug_container.dart';
import 'package:picnic_app/features/deeplink_handler/deeplink_handler_presenter.dart';
import 'package:picnic_app/features/deeplink_handler/deeplink_handler_widget.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';
import 'package:picnic_app/picnic_app_init_params.dart';
import 'package:picnic_app/utils/custom_scroll_behaviour.dart';
import 'package:picnic_app/utils/locale_resolution.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

typedef HomePageProvider = Widget Function();

class PicnicApp extends StatefulWidget {
  const PicnicApp({
    Key? key,
    required this.initParams,
    required this.homePageProvider,
    this.overrideDependencies,
  }) : super(key: key);

  /// used to await app initialization process done in AppInitUseCase, do not use it manually, instead
  /// call PicnicApp.ensureAppInitialized() if needed
  static Completer<void> appInitCompleter = Completer();

  final VoidCallback? overrideDependencies;
  final HomePageProvider homePageProvider;
  final PicnicAppInitParams initParams;

  @override
  State<PicnicApp> createState() => _PicnicAppState();

  static Future<void> ensureAppInitialized() => appInitCompleter.future;

  static _PicnicAppState? of(BuildContext context) => context.findAncestorStateOfType<_PicnicAppState>();
}

class _PicnicAppState extends State<PicnicApp> {
  late Widget page;
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });

    /// Necessary because changing locale takes a while and unfortunately we need it
    /// because our AppNavigator.currentContext doesn't update on change locale we need it
    Future.delayed(
      const ExtraShortDuration(),
      () => _rebuildAllChildren(context),
    );
  }

  @override
  void initState() {
    configureDependencies(widget.initParams);
    widget.overrideDependencies?.call();
    page = widget.homePageProvider.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final materialApp = Builder(
      builder: (context) {
        return MaterialApp(
          home: page,
          // ignoring on purpose, one of the only allowed used of navigatorKey
          // ignore: invalid_use_of_protected_member
          navigatorKey: AppNavigator.navigatorKey,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          theme: PicnicTheme.of(context).materialThemeData,
          navigatorObservers: [
            getIt<AnalyticsObserver>(),
            getIt<RootNavigatorObserver>(),
          ],
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            CountryLocalizations.delegate,
          ],
          localeListResolutionCallback: localeResolution,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          scrollBehavior: const CustomScrollBehaviour(),
        );
      },
    );

    return DeeplinkHandlerWidget(
      presenter: getIt<DeeplinkHandlerPresenter>(),
      child: ForceLogOutObserver(
        presenter: getIt<ForceLogOutObserverPresenter>(),
        child: ConnectionStatusHandlerWidget(
          presenter: getIt(),
          child: PicnicTheme(
            child: widget.initParams.showDebugScreen ? DebugContainer(child: materialApp) : materialApp,
          ),
        ),
      ),
    );
  }

  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
