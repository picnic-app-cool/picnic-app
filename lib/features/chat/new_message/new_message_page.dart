import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presenter.dart';
import 'package:picnic_app/features/chat/new_message/widget/new_message_group_input.dart';
import 'package:picnic_app/features/chat/new_message/widget/new_message_search_input.dart';
import 'package:picnic_app/features/chat/new_message/widget/new_message_users_list.dart';
import 'package:picnic_app/features/chat/widgets/chat_input/chat_input_bar.dart';
import 'package:picnic_app/features/media_picker/widgets/media_picker.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NewMessagePage extends StatefulWidget with HasPresenter<NewMessagePresenter> {
  const NewMessagePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final NewMessagePresenter presenter;

  @override
  State<NewMessagePage> createState() => _NewMessagePageState();
}

class _NewMessagePageState extends State<NewMessagePage>
    with PresenterStateMixin<NewMessageViewModel, NewMessagePresenter, NewMessagePage> {
  late FocusNode focusNodeSearchInput;
  late FocusNode focusNodeGroupInput;
  late FocusNode focusNodeChatBarInput;
  late TextEditingController textEditingControllerSearchInput;
  late TextEditingController textEditingControllerGroupInput;

  @override
  void initState() {
    super.initState();
    presenter.onInitState();
    focusNodeSearchInput = FocusNode();
    focusNodeGroupInput = FocusNode();
    focusNodeChatBarInput = FocusNode();
    textEditingControllerSearchInput = TextEditingController();
    textEditingControllerGroupInput = TextEditingController();
    focusNodeSearchInput.addListener(() {
      presenter.searchInputFocusChanged(hasFocus: focusNodeSearchInput.hasFocus);
    });
    focusNodeGroupInput.addListener(() {
      presenter.groupInputFocusChanged(hasFocus: focusNodeGroupInput.hasFocus);
    });
    focusNodeChatBarInput.addListener(() {
      presenter.chatInputFocusChanged(hasFocus: focusNodeChatBarInput.hasFocus);
    });
  }

  @override
  void dispose() {
    focusNodeSearchInput.dispose();
    focusNodeGroupInput.dispose();
    focusNodeChatBarInput.dispose();
    textEditingControllerSearchInput.dispose();
    textEditingControllerGroupInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final darkBlue = colors.darkBlue.shade600;
    final gray = colors.blackAndWhite.shade600;
    final blue = colors.blue.shade600;

    final appBar = PicnicAppBar(
      iconPathLeft: Assets.images.close.path,
      titleText: appLocalizations.chatNewMessageTitle,
    );

    return DarkStatusBar(
      child: stateObserver(
        builder: (context, state) => Scaffold(
          backgroundColor: blackAndWhite.shade100,
          appBar: appBar,
          resizeToAvoidBottomInset: state.resizeToAvoidBottomInset,
          body: Column(
            children: [
              NewMessageSearchInput(
                showSelectedRecipients: state.showRecipients,
                onTapRemoveRecipient: presenter.onTapRemoveRecipient,
                onChangedSearchText: presenter.onChangedSearchText,
                textEditingController: textEditingControllerSearchInput,
                focusNode: focusNodeSearchInput,
                recipients: state.recipients,
              ),
              const Gap(4),
              if (state.isGroup)
                NewMessageGroupInput(
                  focusNode: focusNodeGroupInput,
                  onChangedUpdateGroupName: presenter.onGroupNameUpdated,
                  textEditingController: textEditingControllerGroupInput,
                ),
              NewMessageUsersList(
                users: state.users,
                loadMore: Future.value,
                onTapAddRecipient: _onAddRecipient,
              ),
              ChatInputBar(
                onTapAddAttachment: presenter.onTapAddAttachment,
                onMessageUpdated: presenter.onMessageTextUpdated,
                sendMessageColor: darkBlue,
                attachmentIconColor: state.isMediaPickerVisible ? blue : gray,
                focusNode: focusNodeChatBarInput,
                attachments: state.selectedAttachments,
                onTapDeleteAttachment: presenter.onTapDeleteAttachment,
                onTapSendMessage: state.sendMessageEnabled ? presenter.onTapSendNewMassage : null,
                additionalBottomPadding: state.isMediaPickerVisible ? 0 : MediaQuery.of(context).padding.bottom,
              ),
              MediaPicker(
                isVisible: state.isMediaPickerVisible,
                presenter: presenter.mediaPickerPresenter,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onAddRecipient(User user) {
    presenter.onTapAddRecipient(user);
    textEditingControllerSearchInput.clear();
  }
}
