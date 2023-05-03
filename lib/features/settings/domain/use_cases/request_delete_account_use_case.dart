import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';
import 'package:picnic_app/features/settings/domain/model/request_delete_account_failure.dart';

class RequestDeleteAccountUseCase {
  const RequestDeleteAccountUseCase(this._privateProfileRepository);

  final PrivateProfileRepository _privateProfileRepository;

  Future<Either<RequestDeleteAccountFailure, Unit>> execute({
    required DeleteAccountReasonInput deleteAccountReasonInput,
  }) async {
    return _privateProfileRepository.requestDeleteAccount(
      deleteAccountReasonInput: deleteAccountReasonInput,
    );
  }
}
