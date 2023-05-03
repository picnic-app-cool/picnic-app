import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/background_api_execution_repository.dart';
import 'package:picnic_app/core/utils/background_call.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late BackgroundApiExecutionRepository _repository;

  final fakeCall = _FakeBackgroundCall();

  setUp(
    () {
      when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
      _repository = BackgroundApiExecutionRepository();
    },
  );

  test("registerBackgroundCall() should add the call to the queue and execute it", () async {
    final stream = _repository.getProgressStream<Unit, Unit, Unit>().takeWhile((list) => list.isNotEmpty);
    final resultsFuture = stream.takeWhile((list) => list.isNotEmpty).toList();
    await _repository.registerBackgroundCall(apiCall: fakeCall);
    final results = await resultsFuture;
    expect(results.last.first.isSuccess, true);
  });

  test("restartBackgroundCall() should restart failed call", () async {
    final stream = _repository.getProgressStream<Unit, Unit, Unit>().takeWhile((list) => list.isNotEmpty);
    final resultsFuture = stream.takeWhile((list) => list.isNotEmpty).toList();
    await _repository.registerBackgroundCall(
      apiCall: fakeCall.byUpdatingStatus(fakeCall.status.toFailed(failure: unit)),
    );
    await _repository.restartBackgroundCall(
      id: fakeCall.id,
    );

    final results = await resultsFuture;
    expect(results.first.first.isFailed, true);
    expect(results[1].first.isInProgress, true);
    expect(results.last.first.isSuccess, true);
  });

  test("removeBackgroundCall() should remove api call", () async {
    final stream = _repository.getProgressStream<Unit, Unit, Unit>().takeWhile((list) => list.isNotEmpty);
    final resultsFuture = stream.takeWhile((list) => list.isNotEmpty).toList();
    await _repository.registerBackgroundCall(
      apiCall: fakeCall.byUpdatingStatus(fakeCall.status.toFailed(failure: unit)),
    );
    await _repository.removeBackgroundCall(
      id: fakeCall.id,
    );

    final results = await resultsFuture;
    expect(results.first.first.isFailed, true);
    expect(results.length, 1);
  });

  test("reportProgressPercentage() should update ProgressStream", () async {
    final stream = _repository.getProgressStream<Unit, Unit, Unit>().takeWhile((list) => list.isNotEmpty);
    final resultsFuture = stream.takeWhile((list) => list.isNotEmpty).toList();
    await _repository.registerBackgroundCall(
      apiCall: fakeCall.byUpdatingStatus(fakeCall.status.toFailed(failure: unit)),
    );
    _repository.reportProgressPercentage(
      id: fakeCall.id,
      percentage: 50,
    );
    await _repository.removeBackgroundCall(
      id: fakeCall.id,
    );

    final results = await resultsFuture;
    expect(results.first.first.isFailed, true);
    expect(results[1].first.isInProgress, true);
    expect((results[1].first as BackgroundCallStatusInProgress).percentage, 50);
    expect(results.length, 2);
  });

  test("isNewCallAllowed() should return true if there are no api calls in stack", () async {
    expect(_repository.isNewCallAllowed(), true);
  });

  test("isNewCallAllowed() should return false if there is api call in stack", () async {
    await _repository.registerBackgroundCall(
      apiCall: fakeCall.byUpdatingStatus(fakeCall.status.toFailed(failure: unit)),
    );
    expect(_repository.isNewCallAllowed(), false);
  });
}

class _FakeBackgroundCall extends Fake implements BackgroundCall<Unit, Unit, Unit> {
  _FakeBackgroundCall() : id = const Id('fake_call') {
    status = BackgroundCallStatusInProgress(
      id: const Id('fake_call'),
      entity: unit,
      percentage: 0,
    );
  }

  _FakeBackgroundCall._({
    required this.id,
    required this.status,
  });

  @override
  final Id id;

  @override
  late final BackgroundCallStatus<Unit, Unit, Unit> status;

  @override
  Future<Either<Unit, Unit>> execute() async {
    return successFuture(unit);
  }

  @override
  BackgroundCall<Unit, Unit, Unit> byUpdatingStatus(BackgroundCallStatus<Unit, Unit, Unit> status) {
    return _FakeBackgroundCall._(
      id: id,
      status: status,
    );
  }
}
