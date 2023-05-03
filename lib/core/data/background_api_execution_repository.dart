import 'dart:async';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

class BackgroundApiExecutionRepository implements BackgroundApiRepository {
  BackgroundApiExecutionRepository();

  static const maximumNumberOfConcurrentCalls = 1;

  List<BackgroundCall<dynamic, dynamic, dynamic>> _backgroundCalls = [];
  bool _isUploadingInProgress = false;
  final StreamController<List<BackgroundCallStatus<dynamic, dynamic, dynamic>>> _streamController =
      StreamController.broadcast();

  @override
  Future<void> registerBackgroundCall({
    required BackgroundCall<dynamic, dynamic, dynamic> apiCall,
  }) async {
    _backgroundCalls = [..._backgroundCalls, apiCall];
    _notifyProgressChanges();
    unawaited(_startCall());
  }

  @override
  Future<void> removeBackgroundCall({
    required Id id,
  }) async {
    _backgroundCalls = [..._backgroundCalls] //
      ..removeWhere((call) => call.id == id);
    _notifyProgressChanges();
    unawaited(_startCall());
  }

  @override
  Future<void> restartBackgroundCall({
    required Id id,
  }) async {
    _updateCallStatus(
      id: id,
      statusUpdate: (status) => status.toInProgress(percentage: 0),
    );
    unawaited(_startCall());
  }

  @override
  void reportProgressPercentage({
    required Id id,
    required int percentage,
  }) {
    _updateCallStatus(
      id: id,
      statusUpdate: (status) => status.toInProgress(percentage: percentage),
    );
  }

  @override
  Stream<List<BackgroundCallStatus<D, F, R>>> getProgressStream<D, F, R>() {
    final type = D.toString();
    return _streamController.stream.map(
      (list) => list //
          .where((element) => element.entityType == type)
          .map((e) => e as BackgroundCallStatus<D, F, R>)
          .toList(),
    );
  }

  @override
  bool isNewCallAllowed() => _backgroundCalls.length < maximumNumberOfConcurrentCalls;

  Future<void> _startCall() async {
    final call = _backgroundCalls.firstOrNull;
    if (_isUploadingInProgress || call == null || call.status.isFailed) {
      return;
    }

    _isUploadingInProgress = true;
    reportProgressPercentage(id: call.id, percentage: 0);
    final result = await call.execute();
    if (result.isSuccess) {
      _updateCallStatus(
        id: call.id,
        statusUpdate: (status) => status.toSuccess(result: result.getSuccess()),
      );
      _backgroundCalls = [..._backgroundCalls] //
        ..removeWhere((element) => element.id == call.id);
    } else {
      _updateCallStatus(
        id: call.id,
        statusUpdate: (status) => status.toFailed(failure: result.getFailure()),
      );
    }
    _notifyProgressChanges();
    _isUploadingInProgress = false;
  }

  void _updateCallStatus({
    required Id id,
    required BackgroundCallStatus<dynamic, dynamic, dynamic> Function(BackgroundCallStatus<dynamic, dynamic, dynamic>)
        statusUpdate,
  }) {
    _backgroundCalls = _backgroundCalls.byUpdatingItem(
      update: (call) => call.byUpdatingStatus(statusUpdate(call.status)),
      itemFinder: (call) => call.id == id,
    );
    _notifyProgressChanges();
  }

  void _notifyProgressChanges() {
    _streamController.add(
      _backgroundCalls.map((call) => call.status).toList(),
    );
  }
}
