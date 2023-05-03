import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/profile/domain/model/save_avatar_border_failure.dart';

class SaveAvatarBorderUseCase {
  const SaveAvatarBorderUseCase();

  Future<Either<SaveAvatarBorderFailure, Unit>> execute() async {
    return left(const SaveAvatarBorderFailure.unknown());
  }
}
