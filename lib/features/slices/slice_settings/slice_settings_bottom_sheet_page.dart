import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SliceSettingsBottomSheetPage extends StatefulWidget with HasPresenter<SliceSettingsPresenter> {
  const SliceSettingsBottomSheetPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final SliceSettingsPresenter presenter;

  @override
  State<SliceSettingsBottomSheetPage> createState() => _SliceSettingsPageState();
}

class _SliceSettingsPageState extends State<SliceSettingsBottomSheetPage>
    with PresenterStateMixin<SliceSettingsViewModel, SliceSettingsPresenter, SliceSettingsBottomSheetPage> {
  static const _horizontalPadding = 20.0;
  static const _verticalSpacing = 20.0;
  static const _iconWidth = 20.0;

  @override
  Widget build(BuildContext context) {
    final bottomNavBarHeight = BottomNavigationSizeQuery.of(context).height;

    return LightStatusBar(
      child: stateObserver(
        builder: (context, state) => Container(
          padding: EdgeInsets.only(
            left: _horizontalPadding,
            right: _horizontalPadding,
            bottom: bottomNavBarHeight,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(_verticalSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PicnicActionButton(
                    icon: Image.asset(Assets.images.share.path, width: _iconWidth),
                    label: appLocalizations.shareAction,
                    onTap: presenter.onTapShare,
                  ),
                  PicnicActionButton(
                    icon: Image.asset(Assets.images.report.path, width: _iconWidth),
                    label: appLocalizations.reportAction,
                    onTap: presenter.onTapReport,
                  ),
                  if (state.canEditSlice) ...[
                    PicnicActionButton(
                      icon: Image.asset(Assets.images.editStroked.path, width: _iconWidth),
                      label: appLocalizations.editAction,
                      onTap: presenter.onTapEdit,
                    ),
                  ],
                  PicnicActionButton(
                    label: state.isJoined ? appLocalizations.leaveAction : appLocalizations.joinAction,
                    onTap: state.isJoined ? presenter.onTapLeave : presenter.onTapJoin,
                    icon: Image.asset(state.isJoined ? Assets.images.logout.path : Assets.images.login.path),
                  ),
                ],
              ),
              const Gap(_verticalSpacing),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.closeAction,
                  onTap: presenter.onTapClose,
                ),
              ),
              const Gap(_verticalSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
