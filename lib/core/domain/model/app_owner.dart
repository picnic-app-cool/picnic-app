import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AppOwner extends Equatable {
  const AppOwner({
    required this.id,
    required this.name,
  });

  const AppOwner.empty()
      : id = const Id.empty(),
        name = '';

  final Id id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];

  AppOwner copyWith({
    Id? id,
    String? name,
  }) {
    return AppOwner(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
