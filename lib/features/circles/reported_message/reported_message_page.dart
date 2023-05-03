// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/chat/chat_feed/widgets/feed_list_item.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presentation_model.dart';
import 'package:picnic_app/features/circles/reported_message/reported_message_presenter.dart';
import 'package:picnic_app/features/circles/reported_message/widgets/ban_spammer_sheet.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ReportedMessagePage extends StatefulWidget with HasPresenter<ReportedMessagePresenter> {
  const ReportedMessagePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ReportedMessagePresenter presenter;

  @override
  State<ReportedMessagePage> createState() => _ReportedMessagePageState();
}

class _ReportedMessagePageState extends State<ReportedMessagePage>
    with PresenterStateMixin<ReportedMessageViewModel, ReportedMessagePresenter, ReportedMessagePage> {
  static const _backgroundOpacity = 0.54;

  @override
  Widget build(BuildContext context) {
    return stateObserver(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: PicnicTheme.of(context).colors.blackAndWhite.shade900.withOpacity(_backgroundOpacity),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FeedListItem(
                    chatMessagesFeed: state.chatMessagesFeed,
                    messageIdToScrollTo: state.reportedMessageId,
                  ),
                ),
              ),
              BanSpammerSheet(
                onTapClose: presenter.onTapClose,
                onTapBan: presenter.onTapBanUser,
                onTapRemoveMessage: presenter.onTapRemove,
                onTapResolveNoAction: presenter.onTapResolveWithNoAction,
              ),
            ],
          ),
        );
      },
    );
  }
}
