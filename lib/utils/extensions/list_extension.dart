extension ListExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];

  List<T> get unmodifiable => List.unmodifiable(this);

  List<T> byUpdatingItem({
    required T Function(T) update,
    required bool Function(T) itemFinder,
  }) {
    final index = indexWhere((element) => itemFinder(element));
    final list = [...this];
    if (index != -1) {
      list[index] = update(list[index]);
    }
    return list.unmodifiable;
  }
}
