import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Seed extends Equatable {
  const Seed({
    required this.amountAvailable,
    required this.amountLocked,
    required this.amountTotal,
    required this.circle,
  });

  const Seed.empty()
      : amountAvailable = 0,
        amountLocked = 0,
        amountTotal = 0,
        circle = const Circle.empty();

  final int amountAvailable;
  final int amountLocked;
  final int amountTotal;
  final Circle circle;

  String get circleName => circle.name;

  Id get circleId => circle.id;

  String get circleEmoji => circle.emoji;

  String get circleImage => circle.imageFile;

  @override
  List<Object?> get props => [
        amountAvailable,
        amountLocked,
        amountTotal,
        circle,
      ];

  Seed copyWith({
    int? amountAvailable,
    int? amountLocked,
    int? amountTotal,
    Circle? circle,
  }) {
    return Seed(
      amountAvailable: amountAvailable ?? this.amountAvailable,
      amountLocked: amountLocked ?? this.amountLocked,
      amountTotal: amountTotal ?? this.amountTotal,
      circle: circle ?? this.circle,
    );
  }
}
