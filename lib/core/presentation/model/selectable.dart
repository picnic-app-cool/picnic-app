import 'package:equatable/equatable.dart';

/// denotes an element that can be selected or not
class Selectable<T> extends Equatable {
  const Selectable({
    required this.item,
    this.selected = false,
  });

  final T item;
  final bool selected;

  @override
  List<Object?> get props => [
        item,
        selected,
      ];

  Selectable<T> copyWith({
    T? item,
    bool? selected,
  }) {
    return Selectable(
      item: item ?? this.item,
      selected: selected ?? this.selected,
    );
  }
}
