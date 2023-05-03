//ignore_for_file: forbidden_import_in_domain,missing_props_items

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/message_action_result.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';

class PopUpMenuItem extends Equatable implements MessageActionResult {
  const PopUpMenuItem._({required this.label, required this.icon});

  factory PopUpMenuItem.replyAction() => PopUpMenuItem._(
        label: appLocalizations.replyAction,
        icon: Assets.images.reply.path,
      );

  factory PopUpMenuItem.copyTextAction() => PopUpMenuItem._(
        label: appLocalizations.copyTextAction,
        icon: Assets.images.copy.path,
      );

  factory PopUpMenuItem.saveAttachmentsAction({required int count}) => PopUpMenuItem._(
        label: appLocalizations.saveAttachmentsAction(count),
        icon: Assets.images.saveAttachments.path,
      );

  factory PopUpMenuItem.deleteMessageAction() => PopUpMenuItem._(
        label: appLocalizations.deleteMessageAction,
        icon: Assets.images.delete.path,
      );

  factory PopUpMenuItem.deleteMultipleMessagesAction() => PopUpMenuItem._(
        label: appLocalizations.deleteMultipleMessagesAction,
        icon: Assets.images.delete.path,
      );

  factory PopUpMenuItem.banUserAction() => PopUpMenuItem._(
        label: appLocalizations.banUserAction,
        icon: Assets.images.close.path,
      );

  factory PopUpMenuItem.reportAction() => PopUpMenuItem._(
        label: appLocalizations.reportAction,
        icon: Assets.images.report.path,
      );

  factory PopUpMenuItem.resendAction() => PopUpMenuItem._(
        label: appLocalizations.resendAction,
        icon: Assets.images.reply.path,
      );

  factory PopUpMenuItem.empty() => const PopUpMenuItem._(
        label: '',
        icon: '',
      );

  final String label;
  final String icon;

  static List<PopUpMenuItem> get values => [
        PopUpMenuItem.replyAction(),
        PopUpMenuItem.copyTextAction(),
        PopUpMenuItem.deleteMessageAction(),
        PopUpMenuItem.deleteMultipleMessagesAction(),
        PopUpMenuItem.banUserAction(),
        PopUpMenuItem.reportAction(),
        PopUpMenuItem.resendAction(),
      ];

  @override
  List<Object?> get props => [icon];

  @override
  MessageActionResultType get type => MessageActionResultType.popUpMenuItem;

  Color getColor(PicnicColors colors) {
    final darkBlue = colors.darkBlue.shade500;
    final pink = colors.pink.shade500;

    return this == PopUpMenuItem.banUserAction() ? pink : darkBlue;
  }

  PopUpMenuItem copyWith({String? label, String? icon}) {
    return PopUpMenuItem._(label: label ?? this.label, icon: icon ?? this.icon);
  }
}

extension PopUpMenuItemSwitch on PopUpMenuItem {
  //ignore: long-parameter-list,long-method
  void when({
    Function()? reply,
    Function()? copy,
    Function()? saveAttachments,
    Function()? delete,
    Function()? deleteMultipleMessages,
    Function()? ban,
    Function()? report,
    Function()? resend,
    Function()? orElse,
  }) {
    if (reply != null && this == PopUpMenuItem.replyAction()) {
      reply();
      return;
    }
    if (copy != null && this == PopUpMenuItem.copyTextAction()) {
      copy();
      return;
    }
    if (saveAttachments != null && this == PopUpMenuItem.saveAttachmentsAction(count: 0)) {
      saveAttachments();
      return;
    }
    if (delete != null && this == PopUpMenuItem.deleteMessageAction()) {
      delete();
      return;
    }
    if (deleteMultipleMessages != null && this == PopUpMenuItem.deleteMultipleMessagesAction()) {
      deleteMultipleMessages();
      return;
    }
    if (ban != null && this == PopUpMenuItem.banUserAction()) {
      ban();
      return;
    }
    if (report != null && this == PopUpMenuItem.reportAction()) {
      report();
      return;
    }
    if (resend != null && this == PopUpMenuItem.resendAction()) {
      resend();
      return;
    }
    orElse?.call();
  }
}
