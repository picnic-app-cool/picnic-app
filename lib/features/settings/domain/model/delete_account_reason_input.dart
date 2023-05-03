import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';

class DeleteAccountReasonInput extends Equatable {
  const DeleteAccountReasonInput({
    required this.deleteAccountReason,
    required this.description,
  });

  const DeleteAccountReasonInput.empty()
      : deleteAccountReason = const DeleteAccountReason.empty(),
        description = '';

  final DeleteAccountReason deleteAccountReason;
  final String description;

  @override
  List<Object> get props => [
        deleteAccountReason,
        description,
      ];

  DeleteAccountReasonInput copyWith({
    DeleteAccountReason? deleteAccountReason,
    String? description,
  }) {
    return DeleteAccountReasonInput(
      deleteAccountReason: deleteAccountReason ?? this.deleteAccountReason,
      description: description ?? this.description,
    );
  }
}
