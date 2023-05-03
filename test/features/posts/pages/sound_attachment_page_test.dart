import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/control_audio_play_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_page.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late SoundAttachmentPage page;
  late SoundAttachmentInitialParams initParams;
  late SoundAttachmentPresentationModel model;
  late SoundAttachmentPresenter presenter;
  late SoundAttachmentNavigator navigator;

  setUp(
    () => {
      when(
        () => PostsMocks.getSoundsListUseCase.execute(
          searchQuery: any(named: "searchQuery"),
          cursor: any(named: "cursor"),
        ),
      ) //
          .thenAnswer(
        (_) => successFuture(
          PaginatedList(
            pageInfo: const PageInfo.singlePage(),
            items: [Stubs.sound1, Stubs.sound2, Stubs.sound3],
          ),
        ),
      ),
      when(
        () => Mocks.controlAudioPlayUseCase.execute(
          action: AudioAction.stop,
        ),
      ) //
          .thenAnswer((_) => Future.value()),
    },
  );

  void _initMvp() {
    initParams = const SoundAttachmentInitialParams();
    model = SoundAttachmentPresentationModel.initial(
      initParams,
    );
    navigator = SoundAttachmentNavigator(Mocks.appNavigator);
    presenter = SoundAttachmentPresenter(
      model,
      navigator,
      PostsMocks.getSoundsListUseCase,
      Mocks.controlAudioPlayUseCase,
      Mocks.debouncer,
    );
    page = SoundAttachmentPage(presenter: presenter);
  }

  await screenshotTest(
    "sound_attachment_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SoundAttachmentPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
