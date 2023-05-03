import 'package:equatable/equatable.dart';

class SliceSettings extends Equatable {
  const SliceSettings({
    required this.isMuted,
  });

  const SliceSettings.empty() : isMuted = false;

  final bool isMuted;

  @override
  List<Object> get props => [
        isMuted,
      ];

  SliceSettings copyWith({
    bool? isMuted,
  }) {
    return SliceSettings(
      isMuted: isMuted ?? this.isMuted,
    );
  }
}
