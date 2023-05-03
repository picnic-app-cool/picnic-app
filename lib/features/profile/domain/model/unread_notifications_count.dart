import 'package:equatable/equatable.dart';

class UnreadNotificationsCount extends Equatable {
  const UnreadNotificationsCount({
    required this.count,
  });

  const UnreadNotificationsCount.empty() : count = 0;

  final int count;

  @override
  List<Object> get props => [
        count,
      ];

  UnreadNotificationsCount copyWith({
    int? count,
  }) {
    return UnreadNotificationsCount(
      count: count ?? this.count,
    );
  }
}
