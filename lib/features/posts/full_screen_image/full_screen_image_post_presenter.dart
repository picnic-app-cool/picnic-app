import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';

class FullScreenImagePostPresenter extends Cubit<FullScreenImagePostViewModel> {
  FullScreenImagePostPresenter(
    super.model,
    this.navigator,
  );

  final FullScreenImagePostNavigator navigator;

  // ignore: unused_element
  FullScreenImagePostPresentationModel get _model => state as FullScreenImagePostPresentationModel;

  void onTapBack() => navigator.close();
}
