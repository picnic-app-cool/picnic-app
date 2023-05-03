import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';

class DeleteAccountInitialParams {
  const DeleteAccountInitialParams({
    this.reportEntityType = DocumentEntityType.deleteAccount,
  });

  final DocumentEntityType reportEntityType;
}
