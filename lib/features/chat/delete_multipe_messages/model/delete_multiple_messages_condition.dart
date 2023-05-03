import 'package:picnic_app/localization/app_localizations_utils.dart';

enum DeleteMultipleMessagesCondition {
  allMessages,
  pastHour,
  pastDay,
  pastWeek,
  pastMonth,
  customTimeFrame;

  String get valueToDisplay {
    switch (this) {
      case DeleteMultipleMessagesCondition.allMessages:
        return appLocalizations.allMessages;
      case DeleteMultipleMessagesCondition.pastHour:
        return appLocalizations.pastHour;
      case DeleteMultipleMessagesCondition.pastDay:
        return appLocalizations.pastDay;
      case DeleteMultipleMessagesCondition.pastWeek:
        return appLocalizations.pastWeek;
      case DeleteMultipleMessagesCondition.pastMonth:
        return appLocalizations.pastMonth;
      case DeleteMultipleMessagesCondition.customTimeFrame:
        return appLocalizations.customTimeFrame;
    }
  }
}
