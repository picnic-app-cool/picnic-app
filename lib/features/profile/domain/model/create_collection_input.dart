import 'package:equatable/equatable.dart';

class CreateCollectionInput extends Equatable {
  const CreateCollectionInput({
    required this.title,
    this.description = '',
    this.isPublic = true,
  });

  const CreateCollectionInput.empty()
      : //
        title = '',
        description = '',
        isPublic = true;

  final String title;
  final String description;
  final bool isPublic;

  @override
  List<Object> get props => [
        title,
        description,
        isPublic,
      ];

  CreateCollectionInput copyWith({
    String? title,
    String? description,
    bool? isPublic,
  }) {
    return CreateCollectionInput(
      title: title ?? this.title,
      description: description ?? this.description,
      isPublic: isPublic ?? this.isPublic,
    );
  }
}
