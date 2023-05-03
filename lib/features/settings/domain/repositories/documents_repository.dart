import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/model/get_delete_account_reasons_failure.dart';

abstract class DocumentsRepository {
  Future<Either<GetDeleteAccountReasonsFailure, List<DeleteAccountReason>>> getDeleteAccountReasons({
    required DocumentEntityType documentEntityType,
  });
}
