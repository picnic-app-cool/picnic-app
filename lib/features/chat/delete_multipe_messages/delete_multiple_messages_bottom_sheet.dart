import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_presentation_model.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_presenter.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/widgets/delete_multiple_messages_composer.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/widgets/delete_multiple_messages_condition_input.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/widgets/delete_multiple_messages_date_time_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/status_bars/light_status_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class DeleteMultipleMessagesBottomSheet extends StatefulWidget with HasPresenter<DeleteMultipleMessagesPresenter> {
  const DeleteMultipleMessagesBottomSheet({
    required this.presenter,
    super.key,
  });

  @override
  final DeleteMultipleMessagesPresenter presenter;

  @override
  State<DeleteMultipleMessagesBottomSheet> createState() => _DeleteMultipleMessagesBottomSheetState();
}

class _DeleteMultipleMessagesBottomSheetState extends State<DeleteMultipleMessagesBottomSheet>
    with
        PresenterStateMixin<DeleteMultipleMessagesViewModel, DeleteMultipleMessagesPresenter,
            DeleteMultipleMessagesBottomSheet> {
  static const _paddingSize = 20.0;
  static const _borderButtonWidth = 2.0;
  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return LightStatusBar(
      child: stateObserver(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(_paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalizations.deleteMultipleMessagesTitle,
                style: theme.styles.subtitle40,
                textAlign: TextAlign.left,
              ),
              const Gap(20),
              PicnicListItem(
                leftGap: 0,
                height: _avatarSize,
                title: state.user.username,
                titleStyle: theme.styles.subtitle20,
                leading: PicnicAvatar(
                  size: _avatarSize,
                  boxFit: PicnicAvatarChildBoxFit.cover,
                  imageSource: PicnicImageSource.url(
                    state.user.profileImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(16),
              DeleteMultipleMessagesComposer(
                conditions: state.conditions,
                onTapItem: presenter.onTapConditionItem,
                child: DeleteMultipleMessagesConditionInput(
                  selectedCondition: state.selectedCondition,
                  onTapInput: presenter.onTapConditionInput,
                ),
              ),
              if (state.isCustomTimeFrame) ...[
                const Gap(16),
                DeleteMultipleMessagesDateTimeInput(
                  title: appLocalizations.dateTimeFromTitle,
                  dateTime: state.dateTimeFrom,
                  onTapInput: () => presenter.onTapDateTimeInput(
                    isDateTimeFrom: true,
                  ),
                ),
                const Gap(8),
                DeleteMultipleMessagesDateTimeInput(
                  title: appLocalizations.dateTimeToTitle,
                  dateTime: state.dateTimeTo,
                  onTapInput: presenter.onTapDateTimeInput,
                ),
              ],
              const Gap(16),
              PicnicButton(
                borderRadius: const PicnicButtonRadius.round(),
                minWidth: double.infinity,
                title: appLocalizations.deleteMultipleMessagesText,
                color: colors.pink,
                borderColor: colors.pink,
                titleColor: colors.blackAndWhite.shade100,
                style: PicnicButtonStyle.outlined,
                borderWidth: _borderButtonWidth,
                onTap: presenter.onTapDeleteMessages,
              ),
              const Gap(4),
              Center(
                child: PicnicTextButton(
                  label: appLocalizations.closeAction,
                  onTap: presenter.onTapClose,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
