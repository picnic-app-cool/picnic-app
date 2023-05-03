import 'package:equatable/equatable.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';

class SelectedTabInfo extends Equatable {
  const SelectedTabInfo({
    required this.item,
    required this.initialOpenTime,
    this.reopenTime,
  });

  final PicnicNavItem item;
  final DateTime initialOpenTime;
  final DateTime? reopenTime;

  @override
  List<Object?> get props => [
        item,
        initialOpenTime,
        reopenTime,
      ];
}
