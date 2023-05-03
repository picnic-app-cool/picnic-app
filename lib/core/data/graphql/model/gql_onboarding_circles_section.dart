import 'package:picnic_app/core/data/graphql/model/gql_basic_circle.dart';
import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/onboarding_circles_section.dart';

class GqlOnboardingCirclesSection {
  const GqlOnboardingCirclesSection({
    required this.name,
    required this.circles,
  });

  factory GqlOnboardingCirclesSection.fromJson(
    Map<String, dynamic> json,
  ) {
    return GqlOnboardingCirclesSection(
      name: asT(json, 'name'),
      circles: asList<GqlBasicCircle>(
        json,
        'circles',
        (element) => GqlBasicCircle.fromJson(element),
      ),
    );
  }

  final String name;
  final List<GqlBasicCircle> circles;

  OnboardingCirclesSection toDomain() => OnboardingCirclesSection(
        name: name,
        circles: circles.map((circle) => circle.toDomain()).toList(),
      );
}
