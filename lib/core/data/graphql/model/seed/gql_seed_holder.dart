import 'package:picnic_app/core/data/graphql/model/gql_public_profile.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/features/seeds/domain/model/seed_holder.dart';

class GqlSeedHolder {
  const GqlSeedHolder({
    required this.owner,
    required this.amountAvailable,
    required this.amountLocked,
    required this.amountTotal,
  });

  factory GqlSeedHolder.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlSeedHolder(
      owner: GqlPublicProfile.fromJson(asT<Map<String, dynamic>>(json, 'owner')),
      amountAvailable: asT(json, 'amountAvailable'),
      amountLocked: asT(json, 'amountLocked'),
      amountTotal: asT(json, 'amountTotal'),
    );
  }

  final GqlPublicProfile owner;
  final int amountAvailable;
  final int amountLocked;
  final int amountTotal;

  SeedHolder toDomain(UserStore userStore) => SeedHolder(
        owner: owner.toDomain(userStore),
        amountAvailable: amountAvailable,
        amountLocked: amountLocked,
        amountTotal: amountTotal,
      );
}
