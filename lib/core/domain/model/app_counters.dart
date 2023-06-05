import 'package:equatable/equatable.dart';

class AppCounters extends Equatable {
  const AppCounters({
    required this.saves,
    required this.circles,
    required this.upvotes,
    required this.reviews,
    required this.avgRating,
  });

  const AppCounters.empty()
      : saves = 0,
        circles = 0,
        upvotes = 0,
        reviews = 0,
        avgRating = 0.0;

  final int saves;
  final int circles;
  final int upvotes;
  final int reviews;
  final double avgRating;

  @override
  List<Object> get props => [
        saves,
        circles,
        upvotes,
        reviews,
        avgRating,
      ];

  AppCounters copyWith({
    int? saves,
    int? circles,
    int? upvotes,
    int? reviews,
    double? avgRating,
  }) {
    return AppCounters(
      saves: saves ?? this.saves,
      circles: circles ?? this.circles,
      upvotes: upvotes ?? this.upvotes,
      reviews: reviews ?? this.reviews,
      avgRating: avgRating ?? this.avgRating,
    );
  }
}
