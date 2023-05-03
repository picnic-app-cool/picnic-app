import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';
import 'package:picnic_app/features/slices/domain/model/approve_join_request_failure.dart';

class ApproveJoinRequestUseCase {
  const ApproveJoinRequestUseCase(this._slicesRepository);

  final SlicesRepository _slicesRepository;

  Future<Either<ApproveJoinRequestFailure, Slice>> execute({required AcceptRequestInput acceptRequestInput}) =>
      _slicesRepository.approveJoinRequest(requestInput: acceptRequestInput);
}
