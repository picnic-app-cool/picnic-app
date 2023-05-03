import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:timeago/timeago.dart';

class TimeAgoMessages implements LookupMessages {
  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => '';

  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) => '';

  @override
  String aboutAMinute(int minutes) => '';

  @override
  String minutes(int minutes) => '';

  @override
  String aboutAnHour(int minutes) => '';

  @override
  String hours(int hours) => appLocalizations.hoursAgo(hours);

  @override
  String aDay(int hours) => appLocalizations.yesterday;

  @override
  String days(int days) => appLocalizations.daysAgo(days);

  @override
  String aboutAMonth(int days) => appLocalizations.monthAgo;

  @override
  String months(int months) => appLocalizations.monthsAgo(months);

  @override
  String aboutAYear(int year) => appLocalizations.yearAgo;

  @override
  String years(int years) => appLocalizations.yearsAgo(years);

  @override
  String wordSeparator() => ' ';
}
