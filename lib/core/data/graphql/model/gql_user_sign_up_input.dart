import 'package:picnic_app/core/data/graphql/graphql_file_variable.dart';
import 'package:picnic_app/core/data/graphql/upload_file_size.dart';

class GqlUserSignUpInput {
  GqlUserSignUpInput({
    required this.username,
    required this.age,
    required this.countryCode,
    required this.languageCodes,
    required this.notificationsEnabled,
    required this.email,
    required this.phone,
    required this.profileImage,
  });

  final String username;
  final int age;
  final String countryCode;
  final List<String> languageCodes;
  final bool notificationsEnabled;
  final String email;
  final String phone;
  final String profileImage;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'age': age,
      'countryCode': countryCode,
      'languageCodes': languageCodes,
      'notificationsEnabled': notificationsEnabled,
      'email': email,
      'phone': phone,
      if (profileImage.isNotEmpty)
        'profileImage': GraphQLFileVariable(
          filePath: profileImage,
          maximumAllowedFileSize: UploadFileSize.profileImage,
        ),
    };
  }
}
