import 'package:equatable/equatable.dart';

class DeleteAccountReason extends Equatable {
  const DeleteAccountReason({
    required this.title,
  });

  const DeleteAccountReason.empty() : title = '';

  final String title;

  @override
  List<Object> get props => [
        title,
      ];

  DeleteAccountReason copyWith({
    String? title,
  }) {
    return DeleteAccountReason(
      title: title ?? this.title,
    );
  }
}
