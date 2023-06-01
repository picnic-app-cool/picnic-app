import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SearchPodInput extends Equatable {
  const SearchPodInput({
    required this.cursor,
    required this.nameStartsWith,
    required this.tagIds,
    required this.orderBy,
  });

  const SearchPodInput.empty()
      : cursor = const Cursor.empty(),
        nameStartsWith = '',
        tagIds = const [],
        orderBy = AppOrder.byScore;

  final Cursor cursor;
  final String nameStartsWith;
  final List<Id> tagIds;
  final AppOrder orderBy;

  @override
  List<Object> get props => [
        cursor,
        nameStartsWith,
        tagIds,
        orderBy,
      ];

  SearchPodInput copyWith({
    Cursor? cursor,
    String? nameStartsWith,
    List<Id>? tagIds,
    AppOrder? orderBy,
  }) {
    return SearchPodInput(
      cursor: cursor ?? this.cursor,
      nameStartsWith: nameStartsWith ?? this.nameStartsWith,
      tagIds: tagIds ?? this.tagIds,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}

enum AppOrder {
  byScore("ByScore"),
  byCreatedAt("ByCreatedAt"),
  unknown("Unknown");

  final String value;

  const AppOrder(this.value);

  static AppOrder fromString(String value) => AppOrder.values.firstWhere(
        (it) => it.value.toLowerCase() == value.trim().toLowerCase(),
        orElse: () => AppOrder.unknown,
      );
}
