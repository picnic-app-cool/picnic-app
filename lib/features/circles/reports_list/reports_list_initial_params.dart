import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/utils.dart';

class ReportsListInitialParams {
  const ReportsListInitialParams({
    required this.circle,
    this.onCircleUpdated,
    this.onCirclePostDeleted,
  });

  final VoidCallback? onCircleUpdated;

  final Circle circle;

  final VoidCallback? onCirclePostDeleted;
}
