// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/debug/debug/debug_presentation_model.dart';
import 'package:picnic_app/features/debug/debug/debug_presenter.dart';
import 'package:picnic_app/features/debug/debug/widgets/additional_headers_section.dart';
import 'package:picnic_app/features/debug/debug/widgets/auth_token_section.dart';
import 'package:picnic_app/features/debug/debug/widgets/select_environment_section.dart';
import 'package:picnic_app/features/debug/debug/widgets/warnings_section.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class DebugPage extends StatefulWidget with HasPresenter<DebugPresenter> {
  const DebugPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final DebugPresenter presenter;

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> with PresenterStateMixin<DebugViewModel, DebugPresenter, DebugPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PicnicAppBar(
        titleText: "Debug screen",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: stateObserver(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WarningsSection(
                      hasCustomHeaders: state.hasCustomHeaders,
                      usesShortLivedTokens: state.usesShortLivedTokens,
                    ),
                    SelectEnvironmentSection(
                      environments: state.environments,
                      selectedEnvironment: state.selectedEnvironment,
                      onTapEnvironment: presenter.onTapEnvironment,
                    ),
                    const Gap(16),
                    PicnicButton(
                      title: "Log Console",
                      onTap: presenter.onTapLogConsole,
                    ),
                    const Gap(16),
                    PicnicButton(
                      title: 'Features index page',
                      onTap: presenter.onTapIndexPage,
                    ),
                    const Gap(16),
                    PicnicButton(
                      title: 'Feature flags',
                      onTap: presenter.onTapFeatureFlags,
                    ),
                    const Gap(16),
                    PicnicButton(
                      title: 'Restart app',
                      onTap: presenter.onTapRestart,
                    ),
                    const Gap(16),
                    AuthTokenSection(
                      onTapSimulateInvalidToken: presenter.onTapSimulateInvalidToken,
                      shouldUseShortLivedTokens: state.usesShortLivedTokens,
                      onChangedShortLivedTokens: presenter.onChangedShortLivedTokens,
                    ),
                    const Gap(16),
                    AdditionalHeadersSection(
                      additionalHeaders: state.additionalGraphqlHeaders,
                      onTapDeleteHeader: presenter.onTapDeleteHeader,
                      onTapEditHeader: presenter.onTapEditHeader,
                      onTapAddHeader: presenter.onTapAddHeader,
                    ),
                    const Gap(16),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
