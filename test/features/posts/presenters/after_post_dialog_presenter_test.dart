import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late AfterPostDialogPresentationModel model;
  late AfterPostDialogPresenter presenter;
  late MockAfterPostDialogNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = AfterPostDialogPresentationModel.initial(
      AfterPostDialogInitialParams(post: Stubs.imagePost),
    );
    navigator = MockAfterPostDialogNavigator();
    presenter = AfterPostDialogPresenter(
      model,
      navigator,
      Mocks.getContactsUseCase,
      Mocks.notifyContactUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.uploadContactsUseCase,
      Mocks.getPhoneContactsUseCase,
      Mocks.debouncer,
      Mocks.sharePostUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });
}
