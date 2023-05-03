import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

/// [BackgroundCall] is an interface representing background api call.
/// [D] - domain entity class. It states for the entity representing the object uploading in the moment.
/// May be used to make some preview of the uploading entity.
/// [F] - failure type. This will be failure type you may receive if api call fails.
/// [R] - result type. This will be type of an object you will receive after api call successfully passed.
/// [entity] is inputValue for the api call. Should be able to get serialized to restart the calls after app restart.
/// [execute] describes the implementation of the api call.
abstract class BackgroundCall<D, F, R> {
  Id get id;

  D get entity;

  BackgroundCallStatus<D, F, R> get status;

  Future<Either<F, R>> execute();

  BackgroundCall<D, F, R> byUpdatingStatus(BackgroundCallStatus<D, F, R> status);
}

enum BackgroundCallStatusType {
  inProgress,
  failed,
  success,
}

/// [BackgroundCallStatus] is a sealed class representing current state of the background api call.
/// [D] - domain entity class. It states for the entity representing the object uploading in the moment.
/// May be used to make some preview of the uploading entity.
/// [F] - failure type. This will be failure type you may receive if api call fails.
/// [R] - result type. This will be type of an object you will receive after api call successfully passed.
abstract class BackgroundCallStatus<D, F, R> {
  BackgroundCallStatusType get type;

  Id get id;

  D get entity;

  String get entityType => entity.runtimeType.toString();

  bool get isFailed => type == BackgroundCallStatusType.failed;

  bool get isSuccess => type == BackgroundCallStatusType.success;

  bool get isInProgress => type == BackgroundCallStatusType.inProgress;

  BackgroundCallStatus<D, F, R> toFailed({required F failure}) => BackgroundCallStatusFailed<D, F, R>(
        id: id,
        entity: entity,
        failure: failure,
      );

  BackgroundCallStatus<D, F, R> toInProgress({required int percentage}) => BackgroundCallStatusInProgress<D, F, R>(
        id: id,
        entity: entity,
        percentage: percentage,
      );

  BackgroundCallStatus<D, F, R> toSuccess({required R result}) => BackgroundCallStatusSuccess<D, F, R>(
        id: id,
        entity: entity,
        result: result,
      );
}

class BackgroundCallStatusInProgress<D, F, R> extends BackgroundCallStatus<D, F, R> {
  BackgroundCallStatusInProgress({
    required this.id,
    required this.entity,
    required this.percentage,
  });

  @override
  final Id id;

  @override
  final D entity;

  final int percentage;

  @override
  BackgroundCallStatusType get type => BackgroundCallStatusType.inProgress;
}

class BackgroundCallStatusSuccess<D, F, R> extends BackgroundCallStatus<D, F, R> {
  BackgroundCallStatusSuccess({
    required this.id,
    required this.entity,
    required this.result,
  });

  @override
  final Id id;

  @override
  final D entity;

  final R result;

  @override
  BackgroundCallStatusType get type => BackgroundCallStatusType.success;
}

class BackgroundCallStatusFailed<D, F, R> extends BackgroundCallStatus<D, F, R> {
  BackgroundCallStatusFailed({
    required this.id,
    required this.entity,
    required this.failure,
  });

  @override
  final Id id;

  @override
  final D entity;

  final F failure;

  @override
  BackgroundCallStatusType get type => BackgroundCallStatusType.failed;
}

extension BackgroundCallStatusSwitch<D, F, R> on BackgroundCallStatus<D, F, R> {
  T when<T>({
    required T Function(BackgroundCallStatusInProgress<D, F, R> status) inProgress,
    required T Function(BackgroundCallStatusSuccess<D, F, R> status) success,
    required T Function(BackgroundCallStatusFailed<D, F, R> status) failed,
  }) {
    switch (type) {
      case BackgroundCallStatusType.inProgress:
        return inProgress(this as BackgroundCallStatusInProgress<D, F, R>);
      case BackgroundCallStatusType.success:
        return success(this as BackgroundCallStatusSuccess<D, F, R>);
      case BackgroundCallStatusType.failed:
        return failed(this as BackgroundCallStatusFailed<D, F, R>);
    }
  }
}
