import 'package:intl/intl.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

//ignore_for_file:no-magic-number
extension TimeAgoFormatting on DateTime {
  String timeElapsed() {
    final currentTimeProvider = getIt<CurrentTimeProvider>();
    var elapsed = currentTimeProvider.currentTime.millisecondsSinceEpoch - millisecondsSinceEpoch;
    final seconds = elapsed / 1000;
    final minutes = seconds / 60;
    final hours = minutes / 60;
    final days = hours / 24;
    final years = days / 365;

    String result;
    if (seconds <= 0) {
      result = appLocalizations.secondsTimeAgo(0);
    } else if (seconds < 60) {
      result = appLocalizations.secondsTimeAgo(seconds.floor());
    } else if (minutes < 60) {
      result = appLocalizations.minutesTimeAgo(minutes.floor());
    } else if (hours < 24) {
      result = appLocalizations.hoursTimeAgo(hours.floor());
    } else if (days < 7) {
      result = appLocalizations.daysTimeAgo(days.floor());
    } else if (years < 1) {
      result = DateFormat("MMM d").format(this);
    } else {
      result = DateFormat("MMM d, yyyy").format(this);
    }

    return result;
  }
}

extension TimeFormatting on DateTime {
  String timeElapsedWithoutAgo() {
    final currentTimeProvider = getIt<CurrentTimeProvider>();
    var elapsed = currentTimeProvider.currentTime.millisecondsSinceEpoch - millisecondsSinceEpoch;
    final seconds = elapsed / 1000;
    final minutes = seconds / 60;
    final hours = minutes / 60;
    final days = hours / 24;
    final weeks = days / 7;
    final months = days / 30;
    final years = days / 365;

    String result;
    if (seconds <= 0) {
      result = appLocalizations.secondsTime(0);
    } else if (seconds < 60) {
      result = appLocalizations.secondsTime(seconds.floor());
    } else if (minutes < 60) {
      result = appLocalizations.minutesTime(minutes.floor());
    } else if (hours < 24) {
      result = appLocalizations.hoursTime(hours.floor());
    } else if (days < 7) {
      result = appLocalizations.daysTime(days.floor());
    } else if (weeks < 4) {
      result = appLocalizations.weeksTime(weeks.floor());
    } else if (months <= 12) {
      result = appLocalizations.monthsTime(months.floor());
    } else {
      result = appLocalizations.yearsTime(years.floor());
    }

    return result;
  }
}
