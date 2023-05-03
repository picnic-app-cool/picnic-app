import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/utils/unique_id.dart';

/// non-nullable id type to identify objects, in case of missing id, use [Id.none]
class Id extends Equatable {
  const Id(
    this.value,
  );

  const Id.empty() : value = '';

  const Id.none() : this.empty();

  Id.unique() : value = generateUniqueId();

  final String value;

  @override
  List<Object> get props => [
        value,
      ];

  bool get isNone => this == const Id.none();

  Id copyWith({
    String? value,
  }) {
    return Id(
      value ?? this.value,
    );
  }
}
