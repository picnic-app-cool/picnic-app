import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class PollAnswer extends Equatable {
  const PollAnswer({
    required this.id,
    required this.imageUrl,
    required this.votesCount,
  });

  const PollAnswer.empty()
      : id = const Id.empty(),
        imageUrl = const ImageUrl.empty(),
        votesCount = 0;

  final Id id;
  final ImageUrl imageUrl;
  final int votesCount;

  @override
  List<Object> get props => [
        id,
        imageUrl,
        votesCount,
      ];

  PollAnswer copyWith({
    Id? id,
    ImageUrl? imageUrl,
    int? votesCount,
  }) {
    return PollAnswer(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      votesCount: votesCount ?? this.votesCount,
    );
  }
}
