import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/group_with_circles.dart';
import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';

/// form for circle creation used by presenter/presentationModel
class CreateCircleForm extends Equatable {
  const CreateCircleForm({
    required this.emoji,
    required this.name,
    required this.description,
    required this.language,
    required this.group,
    required this.visibility,
    required this.image,
    required this.userSelectedNewImage,
    required this.userSelectedNewCover,
    required this.coverImage,
  });

  const CreateCircleForm.empty()
      : //
        name = '',
        description = '',
        language = const Language.english(),
        emoji = '😀',
        group = const GroupWithCircles.empty(),
        visibility = CircleVisibility.opened,
        image = '',
        userSelectedNewImage = false,
        userSelectedNewCover = false,
        coverImage = '';

  final String name;
  final String description;
  final Language language;
  final String emoji;
  final GroupWithCircles group;
  final CircleVisibility visibility;
  final String image;
  final bool userSelectedNewImage;
  final bool userSelectedNewCover;
  final String coverImage;

  @override
  List<Object> get props => [
        name,
        description,
        language,
        emoji,
        group,
        visibility,
        image,
        userSelectedNewImage,
        userSelectedNewCover,
        coverImage,
      ];

  bool get isValid =>
      name.isNotEmpty &&
      description.isNotEmpty &&
      language != const Language.empty() &&
      (emoji.isNotEmpty || image.isNotEmpty) &&
      !group.id.isNone;

  CircleInput toCircleInput() => const CircleInput.empty().copyWith(
        moderationType: CircleModerationType.director,
        name: name,
        description: description,
        languageCode: language.code,
        groupId: group.id,
        emoji: emoji,
        visibility: visibility,
        image: image,
        coverImage: coverImage,
        userSelectedNewImage: userSelectedNewImage,
        userSelectedNewCoverImage: userSelectedNewCover,
        userSelectedNewEmoji: !userSelectedNewImage,
      );

  CreateCircleForm copyWith({
    String? name,
    String? description,
    Language? language,
    String? emoji,
    String? image,
    GroupWithCircles? group,
    CircleVisibility? visibility,
    bool? userSelectedNewImage,
    bool? userSelectedNewCover,
    String? coverImage,
  }) {
    return CreateCircleForm(
      name: name ?? this.name,
      description: description ?? this.description,
      language: language ?? this.language,
      emoji: emoji ?? this.emoji,
      group: group ?? this.group,
      visibility: visibility ?? this.visibility,
      image: image ?? this.image,
      userSelectedNewImage: userSelectedNewImage ?? this.userSelectedNewImage,
      userSelectedNewCover: userSelectedNewCover ?? this.userSelectedNewCover,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}
