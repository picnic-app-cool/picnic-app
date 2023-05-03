import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';

//ignore_for_file: missing_empty_constructor
/// Wrapper around the [Either] type that includes information of the source of the result,
/// whether its from cache or network
class CacheableResult<L, R> extends Equatable {
  const CacheableResult({
    required this.result,
    CacheableSource? source,
  }) : source = source ?? CacheableSource.network;

  final Either<L, R> result;
  final CacheableSource source;

  @override
  List<Object?> get props => [
        result,
        source,
      ];

  CacheableResult<L, R2> mapSuccess<R2>(R2 Function(R) mapper) {
    return CacheableResult<L, R2>(
      result: result.mapSuccess(mapper),
      source: source,
    );
  }

  CacheableResult<L2, R> mapFailure<L2>(L2 Function(L) mapper) {
    return CacheableResult<L2, R>(
      result: result.mapFailure(mapper),
      source: source,
    );
  }

  CacheableResult<L, R> copyWith({
    Either<L, R>? result,
    CacheableSource? source,
  }) {
    return CacheableResult(
      result: result ?? this.result,
      source: source ?? this.source,
    );
  }

  CacheableResult<L, R2> castSuccess<R2>() => CacheableResult<L, R2>(
        result: result.map((r) => r as R2),
        source: source,
      );
}

enum CacheableSource {
  cache,
  network;
}

extension CacheableResultToFuture<L, R> on Stream<CacheableResult<L, R>> {
  Future<Either<L, R>> get networkResult async {
    final cacheable = await firstWhere((element) {
      return element.source == CacheableSource.network;
    });
    return cacheable.result;
  }

  Future<Either<L, R>> get firstResult async {
    final firstResult = await first;
    return firstResult.result;
  }

  Stream<CacheableResult<L, R2>> mapSuccess<R2>(R2 Function(R) mapper) {
    return map((event) {
      return event.mapSuccess(mapper);
    });
  }

  Stream<CacheableResult<L2, R>> mapFailure<L2>(L2 Function(L) mapper) {
    return map((event) {
      return event.mapFailure(mapper);
    });
  }
}
