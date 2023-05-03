import 'package:equatable/equatable.dart';

class CustomRoleMeta extends Equatable {
  const CustomRoleMeta({
    required this.configurable,
    required this.deletable,
    required this.assignable,
  });

  const CustomRoleMeta.empty()
      : configurable = false,
        deletable = false,
        assignable = false;

  final bool configurable;
  final bool deletable;
  final bool assignable;

  @override
  List<Object?> get props => [
        configurable,
        deletable,
        assignable,
      ];

  CustomRoleMeta copyWith({
    bool? configurable,
    bool? deletable,
    bool? assignable,
  }) {
    return CustomRoleMeta(
      configurable: configurable ?? this.configurable,
      deletable: deletable ?? this.deletable,
      assignable: assignable ?? this.assignable,
    );
  }
}
