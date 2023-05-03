import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';

class UpdateCircleInput extends Equatable {
  const UpdateCircleInput({
    required this.circleId,
    required this.circleUpdate,
  });

  const UpdateCircleInput.empty()
      : //
        circleId = const Id.empty(),
        circleUpdate = const CircleInput.empty();

  factory UpdateCircleInput.updateModerationTypeForCircle(Circle circle) => UpdateCircleInput(
        circleId: circle.id,
        circleUpdate: const CircleInput.empty().copyWith(
          moderationType: circle.moderationType,
        ),
      );

  factory UpdateCircleInput.updateRulesTextForCircle(Circle circle) => UpdateCircleInput(
        circleId: circle.id,
        circleUpdate: const CircleInput.empty().copyWith(
          rulesText: circle.rulesText,
        ),
      );

  factory UpdateCircleInput.updateCircle(Circle circle) => UpdateCircleInput(
        circleId: circle.id,
        circleUpdate: const CircleInput.empty().copyWith(
          description: circle.description,
          name: circle.name,
          emoji: circle.emoji,
          image: circle.imageFile,
          coverImage: circle.coverImage,
          rulesText: circle.rulesText,
          configs: circle.configs,
        ),
      );
  final Id circleId;
  final CircleInput circleUpdate;

  @override
  List<Object> get props => [
        circleId,
        circleUpdate,
      ];

  UpdateCircleInput copyWith({
    Id? circleId,
    CircleInput? circleUpdate,
  }) {
    return UpdateCircleInput(
      circleId: circleId ?? this.circleId,
      circleUpdate: circleUpdate ?? this.circleUpdate,
    );
  }

  UpdateCircleInput byUpdatingModerationType(CircleModerationType value) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          moderationType: value,
        ),
      );

  UpdateCircleInput byUpdatingRulesText(String rulesText) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          rulesText: rulesText,
        ),
      );

  UpdateCircleInput byUpdatingName(String name) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          name: name,
        ),
      );

  UpdateCircleInput byUpdatingEmoji(String emoji) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          emoji: emoji,
          image: '',
          userSelectedNewImage: false,
          userSelectedNewEmoji: true,
        ),
      );

  UpdateCircleInput byUpdatingImage(String image) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          image: image,
          emoji: '',
          userSelectedNewImage: true,
          userSelectedNewEmoji: false,
        ),
      );

  UpdateCircleInput byUpdatingCoverImage(String coverImage) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          coverImage: coverImage,
          userSelectedNewCoverImage: true,
        ),
      );

  UpdateCircleInput byUpdatingDescription(String description) => copyWith(
        circleUpdate: circleUpdate.copyWith(
          description: description,
        ),
      );

  UpdateCircleInput byUpdatingVisibility(CircleVisibility visibility) => copyWith(
        circleUpdate: circleUpdate.copyWith(visibility: visibility),
      );
}
