import 'package:picnic_app/features/profile/domain/model/create_collection_input.dart';

extension GqlCreateCollectionInput on CreateCollectionInput {
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isPublic': isPublic,
    };
  }
}
