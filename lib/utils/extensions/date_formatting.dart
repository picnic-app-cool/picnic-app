import 'package:intl/intl.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/utils/time_ago_messages.dart';
import 'package:timeago/timeago.dart' as time_ago_formatter;

extension DateFormatting on DateTime {
  String timeAgo(DateTime now, {bool always24Format = false}) {
    time_ago_formatter.setLocaleMessages('en', TimeAgoMessages());
    return isToday(now)
        ? (always24Format ? DateFormat(Constants.dateFormat24hours) : DateFormat.jm()).format(this)
        : time_ago_formatter.format(this, clock: now);
  }

  bool isToday(DateTime now) {
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday(DateTime now) {
    final yesterday = now.subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  String formatSendMessage(DateTime now) {
    return DateFormat(
      isToday(now)
          ? Constants.dateFormat24hours //
          : Constants.dateFormatSingleDay,
    ).format(this);
  }

  String formatMessageDay(DateTime now) {
    if (isToday(now)) {
      return appLocalizations.today.toLowerCase();
    } else if (isYesterday(now)) {
      return appLocalizations.yesterday.toLowerCase();
    } else {
      return DateFormat("MMM d").format(this).toLowerCase();
    }
  }

  String get monthName {
    return DateFormat("MMMM").format(this);
  }

  String to12hoursFormat() => DateFormat.jm().format(this);

  String formatWithPrefix({
    required String? formatPrefix,
    required DateFormat? dateFormat,
  }) {
    return '${formatPrefix ?? ''}${(dateFormat ?? DateFormat.jm()).format(this)}';
  }

  String yMdjmFormat() => '${DateFormat.yMd().format(this)}, ${DateFormat.jm().format(this)}';
}
