import 'package:equatable/equatable.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class AppPermission extends Equatable {
  const AppPermission({
    required this.id,
    required this.dxName,
    required this.uxName,
    required this.description,
    required this.descriptors,
  });

  const AppPermission.empty()
      : id = const Id.empty(),
        dxName = '',
        uxName = '',
        description = '',
        descriptors = const [];

  final Id id;
  final String dxName;
  final String uxName;
  final String description;
  final List<String> descriptors;

  @override
  List<Object> get props => [
        id,
        dxName,
        uxName,
        description,
        descriptors,
      ];

  AppPermission copyWith({
    Id? id,
    String? dxName,
    String? uxName,
    String? description,
    List<String>? descriptors,
  }) {
    return AppPermission(
      id: id ?? this.id,
      dxName: dxName ?? this.dxName,
      uxName: uxName ?? this.uxName,
      description: description ?? this.description,
      descriptors: descriptors ?? this.descriptors,
    );
  }
}
