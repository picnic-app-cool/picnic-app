import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class JoinCircleUseCase {
  const JoinCircleUseCase(
    this._circlesRepository,
    this._userCirclesStore,
  );

  final CirclesRepository _circlesRepository;
  final UserCirclesStore _userCirclesStore;

  Future<Either<JoinCircleFailure, Unit>> execute({
    BasicCircle? circle,
    Id? circleId,
  }) async {
    assert(
      [circle, circleId].any((it) => it != null),
      "either `circle` or `circleId` needs not to be null",
    );
    assert(
      [circle, circleId].any((it) => it == null),
      "you can specify only circle or circleId, not both",
    );
    final id = circle?.id ?? circleId!;
    return _circlesRepository
        .joinCircle(circleId: id)
        .andThen<BasicCircle>((_) {
          return circle == null
              ? _circlesRepository.getBasicCircle(circleId: id).mapFailure(JoinCircleFailure.unknown)
              : Future.value(success(circle));
        })
        .doOn(
          success: (it) => _userCirclesStore.addCircle(it),
        )
        .mapSuccess((_) => unit);
  }
}
