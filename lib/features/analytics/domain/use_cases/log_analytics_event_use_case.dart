import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';

class LogAnalyticsEventUseCase {
  const LogAnalyticsEventUseCase(this._analyticsRepository);

  final AnalyticsRepository _analyticsRepository;

  void execute(AnalyticsEvent event) => _analyticsRepository.logEvent(event);
}
