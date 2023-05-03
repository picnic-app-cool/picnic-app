import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';

class PicnicStat extends Equatable {
  const PicnicStat({
    required this.type,
    required this.count,
  });

  const PicnicStat.empty()
      : type = StatType.views,
        count = 0;

  final StatType type;
  final int count;

  @override
  List<Object?> get props => [
        type,
        count,
      ];

  PicnicStat copyWith({
    StatType? type,
    int? count,
  }) {
    return PicnicStat(
      type: type ?? this.type,
      count: count ?? this.count,
    );
  }
}
