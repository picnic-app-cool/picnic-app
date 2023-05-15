import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AppTag extends Equatable {
  const AppTag({
    required this.id,
    required this.name,
  });

  const AppTag.empty()
      : id = const Id.empty(),
        name = '';

  final Id id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];

  AppTag copyWith({
    Id? id,
    String? name,
  }) {
    return AppTag(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
