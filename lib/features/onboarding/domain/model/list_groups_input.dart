import 'package:equatable/equatable.dart';

class ListGroupsInput extends Equatable {
  const ListGroupsInput({
    this.isTrending = false,
    this.isWithCircles = false,
  });

  const ListGroupsInput.empty()
      : isTrending = false,
        isWithCircles = false;

  final bool isTrending;
  final bool isWithCircles;

  @override
  List<Object?> get props => [
        isTrending,
        isWithCircles,
      ];

  ListGroupsInput copyWith({
    bool? isTrending,
    bool? isWithCircles,
  }) {
    return ListGroupsInput(
      isTrending: isTrending ?? this.isTrending,
      isWithCircles: isWithCircles ?? this.isWithCircles,
    );
  }
}
