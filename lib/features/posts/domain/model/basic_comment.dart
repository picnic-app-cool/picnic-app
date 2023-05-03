import 'package:picnic_app/core/domain/model/user.dart';

abstract class BasicComment {
  User get author;

  String get text;

  bool get isLiked;
}
