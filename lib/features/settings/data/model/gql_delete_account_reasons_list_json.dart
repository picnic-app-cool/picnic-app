import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';

class GqlDeleteAccountReasonsListJson {
  const GqlDeleteAccountReasonsListJson({
    required this.deleteAccountReasons,
  });

  factory GqlDeleteAccountReasonsListJson.fromJson(Map<String, dynamic> json) => GqlDeleteAccountReasonsListJson(
        deleteAccountReasons: asListPrimitive<String>(
          json,
          'reasons',
        ),
      );

  final List<String> deleteAccountReasons;

  List<DeleteAccountReason> toDomain() => deleteAccountReasons.map((e) => DeleteAccountReason(title: e)).toList();
}
