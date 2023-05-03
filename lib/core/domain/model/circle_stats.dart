import 'package:equatable/equatable.dart';

class CircleStats extends Equatable {
  const CircleStats({
    required this.viewsCount,
    required this.postsCount,
    required this.likesCount,
    required this.membersCount,
  });

  const CircleStats.empty()
      : viewsCount = 0,
        postsCount = 0,
        likesCount = 0,
        membersCount = 0;

  final int viewsCount;
  final int postsCount;
  final int likesCount;
  final int membersCount;

  @override
  List<Object> get props => [
        viewsCount,
        postsCount,
        likesCount,
        membersCount,
      ];

  CircleStats copyWith({
    int? viewsCount,
    int? postsCount,
    int? likesCount,
    int? membersCount,
  }) {
    return CircleStats(
      viewsCount: viewsCount ?? this.viewsCount,
      postsCount: postsCount ?? this.postsCount,
      likesCount: likesCount ?? this.likesCount,
      membersCount: membersCount ?? this.membersCount,
    );
  }
}
