import 'package:equatable/equatable.dart';

class UsernameCheckResult extends Equatable {
  const UsernameCheckResult({
    required this.username,
    required this.isTaken,
  });

  const UsernameCheckResult.empty()
      : username = '',
        isTaken = true;

  const UsernameCheckResult.taken(this.username) : isTaken = true;

  const UsernameCheckResult.free(this.username) : isTaken = false;

  final String username;
  final bool isTaken;

  @override
  List<Object> get props => [
        username,
        isTaken,
      ];

  UsernameCheckResult copyWith({
    String? username,
    bool? isTaken,
  }) {
    return UsernameCheckResult(
      username: username ?? this.username,
      isTaken: isTaken ?? this.isTaken,
    );
  }
}
