import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SliceInput extends Equatable {
  const SliceInput({
    required this.name,
    required this.description,
    required this.private,
    required this.discoverable,
    required this.circleID,
    required this.image,
    required this.rules,
  });

  const SliceInput.empty()
      : //
        name = '',
        description = '',
        private = false,
        discoverable = false,
        rules = '',
        circleID = const Id.empty(),
        image = '';

  final String name;
  final String description;
  final bool private;
  final bool discoverable;
  final Id circleID;
  final String image;
  final String rules;

  @override
  List<Object> get props => [
        name,
        description,
        private,
        discoverable,
        circleID,
        image,
        rules,
      ];

  SliceInput copyWith({
    String? name,
    String? description,
    bool? private,
    bool? discoverable,
    Id? circleID,
    String? image,
    String? rules,
  }) {
    return SliceInput(
      name: name ?? this.name,
      description: description ?? this.description,
      private: private ?? this.private,
      discoverable: discoverable ?? this.discoverable,
      circleID: circleID ?? this.circleID,
      image: image ?? this.image,
      rules: rules ?? this.rules,
    );
  }
}
