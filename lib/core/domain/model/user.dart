import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.bio,
    required this.profileImageUrl,
    required this.createdAt,
    required this.isVerified,
    required this.shareLink,
  });

  const User.anonymous()
      : id = const Id(''),
        username = '',
        fullName = '',
        bio = '',
        profileImageUrl = const ImageUrl.empty(),
        createdAt = '',
        shareLink = '',
        isVerified = false;

  const User.empty() : this.anonymous();

  final Id id;
  final String username;
  final String fullName;
  final ImageUrl profileImageUrl;
  final String createdAt;
  final String shareLink;

  final String bio;
  final bool isVerified;

  @override
  List<Object> get props => [
        id,
        username,
        fullName,
        bio,
        profileImageUrl,
        createdAt,
        isVerified,
        shareLink,
      ];

  bool get isAnonymous => id.isNone;

  User copyWith({
    Id? id,
    String? username,
    String? fullName,
    ImageUrl? profileImageUrl,
    String? createdAt,
    String? shareLink,
    String? bio,
    bool? isVerified,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      shareLink: shareLink ?? this.shareLink,
      bio: bio ?? this.bio,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
