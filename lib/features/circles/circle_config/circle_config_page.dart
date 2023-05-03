import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class CircleConfigPage extends StatefulWidget with HasPresenter<CircleConfigPresenter> {
  const CircleConfigPage({
    super.key,
    required this.presenter,
  });

  @override
  final CircleConfigPresenter presenter;

  @override
  State<CircleConfigPage> createState() => _CircleConfigPageState();
}

class _CircleConfigPageState extends State<CircleConfigPage>
    with PresenterStateMixin<CircleConfigViewModel, CircleConfigPresenter, CircleConfigPage> {
  static const _enabledOpacity = 1.0;
  static const _disabledOpacity = 0.5;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Scaffold(
      appBar: PicnicAppBar(
        backgroundColor: theme.colors.blackAndWhite.shade100,
        child: Text(appLocalizations.circleConfigTitle, style: theme.styles.body20),
      ),
      body: stateObserver(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: PicnicLoadingIndicator(),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.configs.length,
                    itemBuilder: (ctx, index) {
                      final config = state.configs[index];
                      final configCanBeChanged = state.isNewCircle ||
                          state.configsAvailableBasedOnRole.firstWhereOrNull(
                                (configAvailable) => config.type == configAvailable.type,
                              ) !=
                              null;
                      return PicnicListItem(
                        title: "${config.displayName} ${config.emoji}",
                        titleStyle: theme.styles.title20,
                        subTitle: config.description,
                        subTitleStyle: theme.styles.caption10,
                        opacity: configCanBeChanged ? _enabledOpacity : _disabledOpacity,
                        onTap: configCanBeChanged ? null : presenter.onDisabledConfigTap,
                        trailing: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: PicnicSwitch(
                            onChanged:
                                configCanBeChanged ? (value) => presenter.onConfigUpdated(config, value: value) : null,
                            value: config.enabled,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state.isCreatingCircle)
                  const PicnicLoadingIndicator()
                else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: PicnicButton(
                        title: appLocalizations.editCircleButtonLabel,
                        onTap: presenter.onTapSave,
                      ),
                    ),
                  ),
                const Gap(32),
              ],
            ),
          );
        },
      ),
    );
  }
}
