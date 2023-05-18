import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class VoteCandidate extends Equatable {
  const VoteCandidate({
    required this.publicProfile,
    required this.votesCount,
    required this.votesPercent,
    required this.position,
    required this.isDirector,
    required this.margin,
  });

  const VoteCandidate.empty()
      : publicProfile = const PublicProfile.empty(),
        votesCount = 0,
        votesPercent = 0.0,
        position = 0,
        isDirector = false,
        margin = 0.0;

  final PublicProfile publicProfile;
  final int votesCount;
  final double votesPercent;
  final int position;
  final bool isDirector;
  final double margin;

  String get username => publicProfile.username;

  ImageUrl get profilePictureUrl => publicProfile.profileImageUrl;

  Id get userId => publicProfile.id;

  @override
  List<Object?> get props => [
        publicProfile,
        votesCount,
        votesPercent,
        position,
        isDirector,
        margin,
      ];

  VoteCandidate copyWith({
    PublicProfile? publicProfile,
    int? votesCount,
    double? votesPercent,
    int? position,
    bool? isDirector,
    double? margin,
  }) {
    return VoteCandidate(
      publicProfile: publicProfile ?? this.publicProfile,
      votesCount: votesCount ?? this.votesCount,
      votesPercent: votesPercent ?? this.votesPercent,
      position: position ?? this.position,
      isDirector: isDirector ?? this.isDirector,
      margin: margin ?? this.margin,
    );
  }
}
