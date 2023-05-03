extension IterableExtensions<E> on Iterable<E> {
  Future<Iterable<R>> mapAsync<R>(Future<R> Function(E) mapper) => Future.wait(map(mapper));
}
