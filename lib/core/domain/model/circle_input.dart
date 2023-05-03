import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';

class CircleInput extends Equatable {
  const CircleInput({
    required this.moderationType,
    required this.name,
    required this.description,
    required this.languageCode,
    required this.private,
    required this.hidden,
    required this.groupId,
    required this.parentId,
    required this.rulesText,
    required this.emoji,
    required this.visibility,
    required this.image,
    required this.userSelectedNewImage,
    required this.userSelectedNewEmoji,
    required this.configs,
    required this.coverImage,
    required this.userSelectedNewCoverImage,
  });

  const CircleInput.empty()
      : //
        moderationType = CircleModerationType.director,
        name = '',
        description = '',
        languageCode = '',
        private = false,
        hidden = false,
        groupId = const Id.empty(),
        parentId = const Id.empty(),
        rulesText = '',
        emoji = '',
        visibility = CircleVisibility.opened,
        image = '',
        userSelectedNewImage = false,
        userSelectedNewEmoji = false,
        userSelectedNewCoverImage = false,
        configs = const [],
        coverImage = '';

  final CircleModerationType moderationType;
  final String name;
  final String description;
  final String languageCode;
  final bool private;
  final bool hidden;
  final Id groupId;
  final Id parentId;
  final String rulesText;
  final String emoji;
  final CircleVisibility visibility;
  final String image;
  final bool userSelectedNewImage;
  final bool userSelectedNewEmoji;
  final List<CircleConfig> configs;
  final String coverImage;
  final bool userSelectedNewCoverImage;

  @override
  List<Object> get props => [
        moderationType,
        name,
        description,
        languageCode,
        private,
        hidden,
        groupId,
        parentId,
        rulesText,
        emoji,
        visibility,
        image,
        userSelectedNewImage,
        userSelectedNewEmoji,
        configs,
        userSelectedNewCoverImage,
        coverImage,
      ];

  CircleInput copyWith({
    CircleModerationType? moderationType,
    String? name,
    String? description,
    String? languageCode,
    bool? private,
    bool? hidden,
    Id? groupId,
    Id? parentId,
    String? rulesText,
    String? emoji,
    CircleVisibility? visibility,
    String? image,
    bool? userSelectedNewImage,
    bool? userSelectedNewEmoji,
    List<CircleConfig>? configs,
    bool? userSelectedNewCoverImage,
    String? coverImage,
  }) {
    return CircleInput(
      moderationType: moderationType ?? this.moderationType,
      name: name ?? this.name,
      description: description ?? this.description,
      languageCode: languageCode ?? this.languageCode,
      private: private ?? this.private,
      hidden: hidden ?? this.hidden,
      groupId: groupId ?? this.groupId,
      parentId: parentId ?? this.parentId,
      rulesText: rulesText ?? this.rulesText,
      emoji: emoji ?? this.emoji,
      visibility: visibility ?? this.visibility,
      image: image ?? this.image,
      userSelectedNewImage: userSelectedNewImage ?? this.userSelectedNewImage,
      userSelectedNewEmoji: userSelectedNewEmoji ?? this.userSelectedNewEmoji,
      configs: configs ?? this.configs,
      userSelectedNewCoverImage: userSelectedNewCoverImage ?? this.userSelectedNewCoverImage,
      coverImage: coverImage ?? this.coverImage,
    );
  }
}
