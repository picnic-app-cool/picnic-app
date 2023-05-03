import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

abstract class BackgroundApiRepository {
  static const requestUniqueId = 'requestUniqueId';

  Future<void> registerBackgroundCall({
    required BackgroundCall<dynamic, dynamic, dynamic> apiCall,
  });

  Future<void> removeBackgroundCall({
    required Id id,
  });

  Future<void> restartBackgroundCall({
    required Id id,
  });

  void reportProgressPercentage({
    required Id id,
    required int percentage,
  });

  Stream<List<BackgroundCallStatus<D, F, R>>> getProgressStream<D, F, R>();

  bool isNewCallAllowed();
}
