import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';

class DeleteAccountReasonsInitialParams {
  const DeleteAccountReasonsInitialParams({
    required this.reasons,
  });

  final List<DeleteAccountReason> reasons;
}
