import 'package:equatable/equatable.dart';

class VersionControlInfo extends Equatable {
  const VersionControlInfo({
    required this.branch,
    required this.commit,
  });

  const VersionControlInfo.empty()
      : branch = '',
        commit = '';

  final String branch;
  final String commit;

  @override
  List<Object?> get props => [
        branch,
        commit,
      ];

  String get copiedInfo {
    var info = '';
    if (branch.isNotEmpty) {
      info = '$info\nbranch: $branch';
    }
    if (commit.isNotEmpty) {
      info = '$info\ncommit: $commit';
    }
    return info;
  }

  VersionControlInfo copyWith({
    String? branch,
    String? commit,
  }) =>
      VersionControlInfo(
        branch: branch ?? this.branch,
        commit: commit ?? this.commit,
      );
}
