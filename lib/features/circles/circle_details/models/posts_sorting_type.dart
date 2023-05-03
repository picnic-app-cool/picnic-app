import 'package:picnic_app/localization/app_localizations_utils.dart';

enum PostsSortingType {
  popularAllTime(value: 'POPULARITY_ALL_TIME'),
  newSort(value: 'NEW'),
  trendingThisWeek(value: 'TRENDING_THIS_WEEK'),
  trendingThisMonth(value: 'TRENDING_THIS_MONTH');

  final String value;

  String get valueToDisplay {
    switch (this) {
      case PostsSortingType.popularAllTime:
        return '🔥 ${appLocalizations.popularAllTime}';
      case PostsSortingType.newSort:
        return '🆕 ${appLocalizations.newText}';
      case PostsSortingType.trendingThisWeek:
        return '⏰ ${appLocalizations.trendingThisWeek}';
      case PostsSortingType.trendingThisMonth:
        return '📅 ${appLocalizations.trendingThisMonth}';
    }
  }

  const PostsSortingType({required this.value});

  static List<PostsSortingType> get allSorts => [
        popularAllTime,
        newSort,
        trendingThisWeek,
        trendingThisMonth,
      ];

  static PostsSortingType fromString(String value) => PostsSortingType.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => PostsSortingType.popularAllTime,
      );

  String toJson() {
    return value;
  }
}
