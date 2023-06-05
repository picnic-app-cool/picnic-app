import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/app_counters.dart';

class GqlAppCounters {
  const GqlAppCounters({
    required this.saves,
    required this.circles,
    required this.upvotes,
    required this.reviews,
    required this.avgRating,
  });

  //ignore: long-method
  factory GqlAppCounters.fromJson(Map<String, dynamic>? json) {
    return GqlAppCounters(
      saves: asT<int>(json, 'saves'),
      circles: asT<int>(json, 'circles'),
      upvotes: asT<int>(json, 'upvotes'),
      reviews: asT<int>(json, 'reviews'),
      avgRating: asT<double>(json, 'avgRating'),
    );
  }

  final int saves;
  final int circles;
  final int upvotes;
  final int reviews;
  final double avgRating;

  AppCounters toDomain() => AppCounters(
        saves: saves,
        circles: circles,
        upvotes: upvotes,
        reviews: reviews,
        avgRating: avgRating,
      );
}
