import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class SeedsOffer extends Equatable {
  const SeedsOffer({
    required this.melonsAmount,
    required this.recipientId,
    required this.circleId,
    required this.seedAmount,
  });

  const SeedsOffer.empty()
      : melonsAmount = 0,
        circleId = const Id.empty(),
        seedAmount = 0,
        recipientId = const Id.empty();

  final Id circleId;
  final int melonsAmount;
  final int seedAmount;
  final Id recipientId;

  @override
  List<Object?> get props => [
        circleId,
        melonsAmount,
        seedAmount,
        recipientId,
      ];

  SeedsOffer copyWith({
    Id? circleId,
    int? melonsAmount,
    int? seedAmount,
    Id? recipientId,
  }) {
    return SeedsOffer(
      circleId: circleId ?? this.circleId,
      melonsAmount: melonsAmount ?? this.melonsAmount,
      seedAmount: seedAmount ?? this.seedAmount,
      recipientId: recipientId ?? this.recipientId,
    );
  }
}
