// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/onboarding_navigator.dart';
import 'package:picnic_app/features/onboarding/onboarding_presentation_model.dart';
import 'package:picnic_app/features/onboarding/onboarding_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/centered_picnic_logo.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_back_button.dart';
import 'package:picnic_app/ui/widgets/nested_navigator.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';

class OnboardingPage extends StatefulWidget with HasPresenter<OnboardingPresenter> {
  const OnboardingPage({
    required this.presenter,
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  final OnboardingPresenter presenter;

  final OnboardingNavigatorKey navigatorKey;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with PresenterStateMixin<OnboardingViewModel, OnboardingPresenter, OnboardingPage> {
  static const _backButtonTop = 8.0;
  static const _backButtonLeft = 16.0;

  bool get _canPop => widget.navigatorKey.currentState?.canPop() ?? false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => presenter.onInit());
  }

  @override
  Widget build(BuildContext context) {
    return DarkStatusBar(
      child: Material(
        child: Stack(
          children: [
            NestedNavigator(
              navigatorKey: widget.navigatorKey,
              initialRoute: const CenteredPicnicLogo(),
              onDidPop: _onPageRemoved,
              onDidPush: _onPageAdded,
              onDidRemove: _onPageRemoved,
              onDidReplace: _onPageAdded,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: _backButtonLeft,
                  top: _backButtonTop,
                ),
                child: OnboardingBackButton(
                  onTap: () => widget.navigatorKey.currentState?.maybePop(),
                  canPop: _canPop,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPageRemoved() =>
      // this causes rebuild so that back button can animate out if its not longer needed
      setState(() => doNothing());

  Future<void> _onPageAdded() async {
    // we delay setState so that Hero animations don't get interrupted
    await Future.delayed(Constants.slidingTransitionDuration);
    if (mounted) {
      // this causes rebuild so that back button can animate in if its not yet present
      setState(() => doNothing());
    }
  }
}
