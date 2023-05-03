part of 'defer_pointer.dart';

/// Holds a list of [_DeferPointerRenderObject]s which the [DeferredPointerHandler] widget uses to perform hit tests.
class DeferredPointerHandlerLink extends ChangeNotifier with EquatableMixin {
  DeferredPointerHandlerLink();
  final List<_DeferPointerRenderObject> _painters = [];

  /// All painters currently attached to this link
  List<_DeferPointerRenderObject> get painters => UnmodifiableListView(_painters);

  @override
  List<Object?> get props => _painters;

  void descendantNeedsPaint() => notifyListeners();

  /// Add a render object to the link. Does nothing if item already exists.
  void add(_DeferPointerRenderObject value) {
    if (!_painters.contains(value)) {
      _painters.add(value);
      notifyListeners();
    }
  }

  /// Remove a render object from the link. Does nothing if item is not in list.
  void remove(_DeferPointerRenderObject value) {
    if (_painters.contains(value)) {
      _painters.remove(value);
      notifyListeners();
    }
  }

  /// Clears all currently attached links
  void removeAll() {
    _painters.clear();
    notifyListeners();
  }
}
