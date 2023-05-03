import 'package:equatable/equatable.dart';

class FutureResult<T> extends Equatable {
  const FutureResult(
    this.result,
    this.status,
    this.error,
  );

  const FutureResult.empty()
      : result = null,
        error = null,
        status = FutureStatus.notStarted;

  const FutureResult.pending()
      : result = null,
        error = null,
        status = FutureStatus.pending;

  const FutureResult.success(this.result)
      : error = null,
        status = FutureStatus.fulfilled;

  final T? result;
  final FutureStatus status;
  final dynamic error;

  bool get isNotStarted => status == FutureStatus.notStarted;

  @override
  List<Object?> get props => [
        result,
        status,
        error,
      ];

  bool isPending() => status == FutureStatus.pending;

  FutureResult<T2> mapResult<T2>(
    T2? Function(T?) mapper,
  ) =>
      FutureResult(
        mapper(result),
        status,
        error,
      );

  FutureResult<T> copyWith({
    T? result,
    FutureStatus? status,
    dynamic error,
  }) =>
      FutureResult<T>(
        result ?? this.result,
        status ?? this.status,
        error ?? this.error,
      );
}

//ignore:prefer-match-file-name
enum FutureStatus {
  notStarted,
  pending,
  fulfilled,
  rejected,
}
