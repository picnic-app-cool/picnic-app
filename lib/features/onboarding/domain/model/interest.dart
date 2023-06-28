import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class Interest extends Equatable {
  const Interest({
    required this.id,
    required this.name,
    required this.emoji,
  });

  const Interest.empty()
      : id = const Id.empty(),
        name = '',
        emoji = '';

  final Id id;

  final String name;

  final String emoji;

  @override
  List<Object?> get props => [
        id,
        name,
        emoji,
      ];

  Interest copyWith({
    Id? id,
    String? name,
    String? emoji,
  }) {
    return Interest(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
    );
  }
}
