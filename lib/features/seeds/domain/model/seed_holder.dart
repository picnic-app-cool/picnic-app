import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';

class SeedHolder extends Equatable {
  const SeedHolder({
    required this.amountAvailable,
    required this.amountLocked,
    required this.amountTotal,
    required this.owner,
  });

  const SeedHolder.empty()
      : amountAvailable = 0,
        amountLocked = 0,
        amountTotal = 0,
        owner = const PublicProfile.empty();

  final int amountAvailable;
  final int amountLocked;
  final int amountTotal;
  final PublicProfile owner;

  String get username => owner.username;

  @override
  List<Object?> get props => [
        amountAvailable,
        amountLocked,
        amountTotal,
        owner,
      ];

  SeedHolder copyWith({
    int? amountAvailable,
    int? amountLocked,
    int? amountTotal,
    PublicProfile? owner,
  }) {
    return SeedHolder(
      amountAvailable: amountAvailable ?? this.amountAvailable,
      amountLocked: amountLocked ?? this.amountLocked,
      amountTotal: amountTotal ?? this.amountTotal,
      owner: owner ?? this.owner,
    );
  }
}
