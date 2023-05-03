import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';

class Royalty extends Equatable {
  const Royalty({
    required this.user,
    required this.points,
  });

  const Royalty.empty()
      : user = const PublicProfile.empty(),
        points = 0;

  final PublicProfile user;

  final int points;

  @override
  List<Object?> get props => [user, points];

  Royalty copyWith({
    PublicProfile? user,
    int? points,
  }) {
    return Royalty(
      user: user ?? this.user,
      points: points ?? this.points,
    );
  }
}
