import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/profile/domain/model/load_avatar_borders_failure.dart';

class LoadAvatarBordersUseCase {
  const LoadAvatarBordersUseCase();

  Future<Either<LoadAvatarBordersFailure, Unit>> execute() async {
    return left(const LoadAvatarBordersFailure.unknown());
  }
}
