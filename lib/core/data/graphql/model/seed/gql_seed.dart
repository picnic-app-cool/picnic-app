import 'package:picnic_app/core/data/graphql/model/gql_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/seeds/domain/model/seed.dart';

class GqlSeed {
  const GqlSeed({
    required this.circle,
    required this.amountAvailable,
    required this.amountLocked,
    required this.amountTotal,
  });

  factory GqlSeed.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlSeed(
      circle: GqlCircle.fromJson(asT<Map<String, dynamic>>(json, 'circle')),
      amountAvailable: asT(json, 'amountAvailable'),
      amountLocked: asT(json, 'amountLocked'),
      amountTotal: asT(json, 'amountTotal'),
    );
  }

  final GqlCircle circle;
  final int amountAvailable;
  final int amountLocked;
  final int amountTotal;

  Seed toDomain() => Seed(
        circle: circle.toDomain(),
        amountAvailable: amountAvailable,
        amountLocked: amountLocked,
        amountTotal: amountTotal,
      );
}
