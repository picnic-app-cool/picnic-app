import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/get_royalty_failure.dart';
import 'package:picnic_app/features/circles/domain/model/royalty.dart';
import 'package:picnic_app/resources/assets.gen.dart';

class GetRoyaltyUseCase {
  const GetRoyaltyUseCase();

  // TODO: Pick this up from the backend
  static final _userOne = const PublicProfile.empty().copyWith(
    user: const User.empty().copyWith(
      username: 'Jack',
      profileImageUrl: ImageUrl(Assets.images.acorn.path),
      isVerified: false,
    ),
    iFollow: true,
  );

  // TODO: Pick this up from the backend
  static final _userTwo = const PublicProfile.empty().copyWith(
    user: const User.empty().copyWith(
      username: 'John',
      profileImageUrl: ImageUrl(Assets.images.rocket.path),
      isVerified: false,
    ),
    iFollow: false,
  );

  //TODO: Create Repo and integrate GraphQl query : https://picnic-app.atlassian.net/browse/GS-2466
  Future<Either<GetRoyaltyFailure, PaginatedList<Royalty>>> execute() async {
    return success(
      PaginatedList(
        items: [
          Royalty(
            user: _userOne,
            //ignore: no-magic-number
            points: 11,
          ),
          Royalty(
            user: _userTwo,
            //ignore: no-magic-number
            points: 10,
          ),
        ],
        pageInfo: const PageInfo.empty(),
      ),
    );
  }
}
