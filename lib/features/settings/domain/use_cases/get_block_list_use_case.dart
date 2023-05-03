import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/get_block_list_failure.dart';

class GetBlockListUseCase {
  const GetBlockListUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<GetBlockListFailure, PaginatedList<PublicProfile>>> execute({required Cursor cursor}) async {
    return _privateProfileRepository.getBlockList(cursor: cursor);
  }
}
