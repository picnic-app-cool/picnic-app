// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds/widgets/sell_seeds_step_indicator.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_page.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/nested_navigator.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SellSeedsPage extends StatefulWidget with HasPresenter<SellSeedsPresenter> {
  const SellSeedsPage({
    required this.presenter,
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  final SellSeedsPresenter presenter;

  final OnboardingNavigatorKey navigatorKey;

  @override
  State<SellSeedsPage> createState() => _SellSeedsPageState();
}

class _SellSeedsPageState extends State<SellSeedsPage>
    with PresenterStateMixin<SellSeedsViewModel, SellSeedsPresenter, SellSeedsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          iconPathLeft: Assets.images.close.path,
          backgroundColor: theme.colors.blackAndWhite.shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(appLocalizations.sendSeedsAction, style: theme.styles.body30),
              stateObserver(
                builder: (context, state) {
                  return Text(
                    appLocalizations.stepFormat(state.sellSeedsStep),
                    style: theme.styles.caption10.copyWith(color: theme.colors.blackAndWhite.shade600),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            stateObserver(
              builder: (context, state) => SellSeedsStepIndicator(
                step: state.step,
              ),
            ),
            Expanded(
              child: NestedNavigator(
                navigatorKey: widget.navigatorKey,
                initialRoute: getIt<SellSeedsFirstStepPage>(
                  param1: SellSeedsFirstStepInitialParams(
                    onChooseCircle: presenter.onChooseCircle,
                    circleId: state.circleId,
                  ),
                ),
                onDidPop: presenter.onGoToFirstStep,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
