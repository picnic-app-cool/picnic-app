import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';

class NewMessageInitialParams {
  const NewMessageInitialParams({
    this.user = const User.empty(),
  });

  final User user;

  MediaPickerInitialParams toMediaPickerInitialParams() => const MediaPickerInitialParams();
}
