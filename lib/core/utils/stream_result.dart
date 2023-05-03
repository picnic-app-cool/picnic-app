import 'package:equatable/equatable.dart';

class StreamResult<T> extends Equatable {
  const StreamResult(
    this.emission,
    this.status,
    this.error,
  );

  const StreamResult.empty()
      : emission = null,
        error = null,
        status = StreamStatus.notStarted;

  const StreamResult.pendingFirstEmission()
      : emission = null,
        error = null,
        status = StreamStatus.pendingFirstEmission;

  const StreamResult.emission(this.emission)
      : error = null,
        status = StreamStatus.emission;

  final T? emission;
  final StreamStatus status;
  final dynamic error;

  bool get isNotStarted => status == StreamStatus.notStarted;

  @override
  List<Object?> get props => [
        emission,
        status,
        error,
      ];

  bool get isPending => ![
        StreamStatus.finished,
        StreamStatus.rejected,
        StreamStatus.notStarted,
      ].contains(status);

  bool get isEmission => status == StreamStatus.emission;

  StreamResult<T2> mapResult<T2>(
    T2? Function(T?) mapper,
  ) =>
      StreamResult(
        mapper(emission),
        status,
        error,
      );

  StreamResult<T> copyWith({
    T? emission,
    StreamStatus? status,
    dynamic error,
  }) {
    return StreamResult<T>(
      emission ?? this.emission,
      status ?? this.status,
      error ?? this.error,
    );
  }
}

//ignore:prefer-match-file-name
enum StreamStatus {
  notStarted,
  pendingFirstEmission,
  emission,
  finished,
  rejected,
}
