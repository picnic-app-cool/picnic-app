import 'package:equatable/equatable.dart';

//ignore_for_file: unused-code, unused-files
class GetVerifiedData extends Equatable {
  const GetVerifiedData({
    required this.title,
    required this.subTitle,
    required this.message,
    required this.listTitle,
    required this.listItems,
  });

  GetVerifiedData.empty()
      : title = "",
        subTitle = "",
        message = "",
        listTitle = "",
        listItems = List.empty();

  final String title;
  final String subTitle;
  final String message;
  final String listTitle;
  final List<String> listItems;

  @override
  List<Object?> get props => [
        title,
        subTitle,
        message,
        listTitle,
        listItems,
      ];

  GetVerifiedData copyWith({
    String? title,
    String? subTitle,
    String? message,
    String? listTitle,
    List<String>? listItems,
  }) {
    return GetVerifiedData(
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      message: message ?? this.message,
      listTitle: listTitle ?? this.listTitle,
      listItems: listItems ?? this.listItems,
    );
  }
}
