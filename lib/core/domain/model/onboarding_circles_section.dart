import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';

class OnboardingCirclesSection extends Equatable {
  const OnboardingCirclesSection({
    required this.name,
    required this.circles,
  });

  const OnboardingCirclesSection.empty()
      : name = '',
        circles = const [];

  final String name;
  final List<BasicCircle> circles;

  @override
  List<Object?> get props => [
        name,
        circles,
      ];

  OnboardingCirclesSection copyWith({
    String? name,
    List<BasicCircle>? circles,
  }) {
    return OnboardingCirclesSection(
      name: name ?? this.name,
      circles: circles ?? this.circles,
    );
  }
}
