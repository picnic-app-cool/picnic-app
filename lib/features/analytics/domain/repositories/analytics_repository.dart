import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';

abstract class AnalyticsRepository {
  void setUser(User? user);
  void logEvent(AnalyticsEvent event);
}
