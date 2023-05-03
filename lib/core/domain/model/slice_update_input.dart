import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SliceUpdateInput extends Equatable {
  const SliceUpdateInput({
    required this.name,
    required this.description,
    required this.private,
    required this.discoverable,
    required this.image,
    required this.rules,
  });

  const SliceUpdateInput.empty()
      : //
        name = '',
        description = '',
        private = false,
        discoverable = false,
        rules = '',
        image = '';

  final String name;
  final String description;
  final bool private;
  final bool discoverable;
  final String image;
  final String rules;

  @override
  List<Object> get props => [
        name,
        description,
        private,
        discoverable,
        image,
        rules,
      ];

  SliceUpdateInput copyWith({
    String? name,
    String? description,
    bool? private,
    bool? discoverable,
    Id? circleID,
    String? image,
    String? rules,
  }) {
    return SliceUpdateInput(
      name: name ?? this.name,
      description: description ?? this.description,
      private: private ?? this.private,
      discoverable: discoverable ?? this.discoverable,
      image: image ?? this.image,
      rules: rules ?? this.rules,
    );
  }
}
