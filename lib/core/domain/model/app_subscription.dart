import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AppSubscription extends Equatable {
  const AppSubscription({
    required this.id,
    required this.description,
  });

  const AppSubscription.empty()
      : id = const Id.empty(),
        description = '';

  final Id id;
  final String description;

  @override
  List<Object> get props => [
        id,
        description,
      ];

  AppSubscription copyWith({
    Id? id,
    String? description,
  }) {
    return AppSubscription(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
