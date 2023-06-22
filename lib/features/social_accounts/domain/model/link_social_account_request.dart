import 'package:equatable/equatable.dart';

class LinkSocialAccountRequest extends Equatable {
  const LinkSocialAccountRequest({
    required this.code,
    required this.redirectUri,
  });

  const LinkSocialAccountRequest.empty()
      : code = '',
        redirectUri = '';

  final String code;
  final String redirectUri;

  @override
  List<Object> get props => [
        code,
        redirectUri,
      ];

  LinkSocialAccountRequest copyWith({
    String? code,
    String? redirectUri,
  }) {
    return LinkSocialAccountRequest(
      code: code ?? this.code,
      redirectUri: redirectUri ?? this.redirectUri,
    );
  }
}
