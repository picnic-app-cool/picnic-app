import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/create_slice/domain/model/slice_input.dart';

/// form for circle creation used by presenter/presentationModel
class CreateSliceForm extends Equatable {
  const CreateSliceForm({
    required this.name,
    required this.description,
    required this.private,
    required this.discoverable,
    required this.imagePath,
  });

  const CreateSliceForm.empty()
      : //
        name = '',
        description = '',
        private = false,
        discoverable = true,
        imagePath = '';

  final String name;
  final String description;
  final bool private;
  final bool discoverable;
  final String imagePath;

  @override
  List<Object> get props => [
        name,
        description,
        private,
        discoverable,
        imagePath,
      ];

  //TODO check against BE if name is valid https://picnic-app.atlassian.net/browse/GS-5177
  bool get isValid => name.isNotEmpty && description.isNotEmpty;

  SliceInput toCreateSliceInput({required Id circleId}) {
    return const SliceInput.empty().copyWith(
      name: name,
      description: description,
      private: private,
      discoverable: discoverable,
      image: imagePath,
      circleID: circleId,
    );
  }

  CreateSliceForm copyWith({
    String? name,
    String? description,
    bool? private,
    bool? discoverable,
    String? imagePath,
  }) {
    return CreateSliceForm(
      name: name ?? this.name,
      description: description ?? this.description,
      private: private ?? this.private,
      discoverable: discoverable ?? this.discoverable,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
