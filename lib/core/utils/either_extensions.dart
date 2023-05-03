import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/logging.dart';

Either<L, R> success<L, R>(R r) => right(r);

Either<L, R> failure<L, R>(L l) => left(l);

extension EitherExtensions<L, R> on Either<L, R> {
  bool get isFailure => isLeft();

  bool get isSuccess => isRight();

  R? getSuccess() => fold((l) => null, (r) => r);

  L? getFailure() => fold((l) => l, (r) => null);

  Either<L2, R> mapFailure<L2>(L2 Function(L fail) errorMapper) {
    return leftMap(errorMapper);
  }

  /// Allows to catch L and return L or R depending on L
  Either<L, R> catchFailure(Function1<L, Either<L, R>> errorMapper) {
    final failure = getFailure();
    return failure != null ? errorMapper(failure) : this;
  }

  /// Allows to catch R and return L or R depending on R
  Either<L, R> catchSuccess(Function1<R, Either<L, R>> errorMapper) {
    final success = getSuccess();
    return success != null ? errorMapper(success) : this;
  }

  Either<L, R2> mapSuccess<R2>(R2 Function(R result) mapper) {
    return map(mapper);
  }

  Future<Either<L, R2>> asyncMap<R2>(Future<R2> Function(R r) f) async => fold(left, (r) async => right(await f(r)));

  Either<L, R> doOn({
    void Function(L fail)? fail,
    void Function(R success)? success,
  }) {
    try {
      fold(
        fail ?? (_) => doNothing(),
        success ?? (_) => doNothing(),
      );
      return this;
    } catch (e, stack) {
      logError(e, stack: stack);
      rethrow;
    }
  }
}

extension FutureEither<L, R> on Future<Either<L, R>> {
  Future<Either<L, R2>> andThen<R2>(Function1<R, Future<Either<L, R2>>> f) {
    return flatMap(f);
  }

  Future<Either<L, R2>> flatMap<R2>(Function1<R, Future<Either<L, R2>>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(left<L, R2>(l)),
        f,
      ),
    );
  }

  /// adds operation after this one succeeds, ignores the result to allow chaining calls like in builder method:
  /// ```dart
  /// someOperation()
  ///   .chainOnSuccess((result) => doSomething())
  ///   .chainOnSuccess((result) => doSomethingElse())
  /// ```
  /// in this case, it will perform `someOperation()`, then `doSomething()` and await its completion and
  /// only after it succeeds, it will continue with `doSomethingElse()`, in case any of those operations fail,
  /// the entire chain fails prematurely without calling subsequent operations.
  Future<Either<L, R>> chainOnSuccess(Function1<R, Future<Either<L, dynamic>>> f) {
    return flatMap((result) async {
      return f(result).mapSuccess((_) {
        return result;
      });
    });
  }

  Future<Either<L, R>> doOnSuccessWait(Function1<R, Future<dynamic>> f) {
    return flatMap((res) async {
      await f(res);
      return success(res);
    });
  }

  Future<Either<L2, R>> leftMap<L2>(Function1<L, Either<L2, R>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(f(l)),
        (r) => Future.value(right<L2, R>(r)),
      ),
    );
  }

  Future<Either<L, R2>> map<R2>(Function1<R, Either<L, R2>> f) {
    return then(
      (either1) => either1.fold(
        (l) => Future.value(left<L, R2>(l)),
        (r) => Future.value(f(r)),
      ),
    );
  }

  Future<Either<L2, R>> mapFailure<L2>(L2 Function(L fail) errorMapper) async {
    return (await this).mapFailure(errorMapper);
  }

  Future<Either<L, R>> catchFailure(Function1<L, Either<L, R>> errorMapper) async {
    return (await this).catchFailure(errorMapper);
  }

  Future<Either<L, R>> catchSuccess(Function1<R, Either<L, R>> errorMapper) async {
    return (await this).catchSuccess(errorMapper);
  }

  Future<Either<L, R2>> mapSuccess<R2>(R2 Function(R response) responseMapper) async {
    return (await this).map(responseMapper);
  }

  Future<Either<L, R2>> mapSuccessAsync<R2>(Future<R2> Function(R response) responseMapper) async {
    return (await this).asyncMap(responseMapper);
  }

  Future<Either<L, R>> doOn({
    void Function(L fail)? fail,
    void Function(R success)? success,
  }) async {
    return (await this).doOn(fail: fail, success: success);
  }

  Future<R2> asyncFold<R2>(
    R2 Function(L fail) fail,
    R2 Function(R success) success,
  ) async =>
      (await this).fold(fail, success);

  Future<R> getOrThrow() async => asyncFold(
        (l) => throw l as Object,
        (r) => r,
      );
}

extension FutureEitherList<L, R> on Iterable<Future<Either<L, R>>> {
  Future<Either<List<L>, List<R>>> zip() async {
    final eitherList = await Future.wait(this);

    final failures = eitherList //
        .where((e) => e.getFailure() != null)
        .map((e) => e.getFailure()!)
        .toList();
    if (failures.isNotEmpty) {
      return failure(failures);
    }

    final results = eitherList //
        .where((e) => e.getSuccess() != null)
        .map((e) => e.getSuccess()!)
        .toList();
    return success(results);
  }

  Future<Either<List<L>, List<R>>> concat() async {
    final eitherList = <Either<L, R>>[];
    for (final future in this) {
      final either = await future;
      eitherList.add(either);
    }

    final failures = eitherList //
        .where((e) => e.getFailure() != null)
        .map((e) => e.getFailure()!)
        .toList();
    if (failures.isNotEmpty) {
      return failure(failures);
    }

    final results = eitherList //
        .where((e) => e.getSuccess() != null)
        .map((e) => e.getSuccess()!)
        .toList();
    return success(results);
  }
}
