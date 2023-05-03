import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/model/get_delete_account_reasons_failure.dart';
import 'package:picnic_app/features/settings/domain/repositories/documents_repository.dart';

class GetDeleteAccountReasonsUseCase {
  const GetDeleteAccountReasonsUseCase(this._documentsRepository);

  final DocumentsRepository _documentsRepository;

  Future<Either<GetDeleteAccountReasonsFailure, List<DeleteAccountReason>>> execute({
    required DocumentEntityType documentEntityType,
  }) async {
    return _documentsRepository.getDeleteAccountReasons(
      documentEntityType: documentEntityType,
    );
  }
}
