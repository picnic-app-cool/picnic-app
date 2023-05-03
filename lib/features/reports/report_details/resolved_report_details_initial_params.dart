import 'package:picnic_app/core/domain/model/basic_public_profile.dart';

class ResolvedReportDetailsInitialParams {
  const ResolvedReportDetailsInitialParams({required this.moderator, required this.resolvedAt});

  final BasicPublicProfile moderator;
  final String resolvedAt;
}
