import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mock_definitions.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late PostCreationIndexPresentationModel model;
  late PostCreationIndexPresenter presenter;
  late MockPostCreationIndexNavigator navigator;
  late PostCreationIndexInitialParams initialParams;

  void _initMvp({Circle circle = const Circle.empty()}) {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    navigator = MockPostCreationIndexNavigator();
    initialParams = PostCreationIndexInitialParams(circle: circle);
    model = PostCreationIndexPresentationModel.initial(
      initialParams,
      Mocks.featureFlagsStore,
    );
    presenter = PostCreationIndexPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.uploadContactsUseCase,
      PostsMocks.createPostUseCase,
    );
  }

  test(
    'tapping on go to settings should open app settings',
    () async {
      // GIVEN
      when(() => Mocks.openNativeAppSettingsUseCase.execute()).thenAnswer((_) => successFuture(true));
      // WHEN
      presenter.onTapGoToSettings();

      // THEN
      verify(() => Mocks.openNativeAppSettingsUseCase.execute());
    },
  );

  test(
    'tapping on the tab should change type',
    () async {
      // WHEN
      presenter.onTabChanged(PostCreationPreviewType.link);
      // THEN
      expect(presenter.state.selectedType, PostCreationPreviewType.link);
    },
  );

  group('tapping on post with empty preselected circle id', () {
    test(
      'image input should open upload media',
      () async {
        // GIVEN
        final input = Stubs.createImagePostInput;
        when(() => navigator.openUploadMedia(any())).thenAnswer((_) async => {});

        // WHEN
        await presenter.onTapPost(input);

        // THEN
        verify(() => navigator.openUploadMedia(any()));
      },
    );
    test(
      'video input should open upload media',
      () async {
        // GIVEN
        final input = Stubs.createVideoPostInput;
        when(() => navigator.openUploadMedia(any())).thenAnswer((_) async => {});

        // WHEN
        await presenter.onTapPost(input);

        // THEN
        verify(() => navigator.openUploadMedia(any()));
      },
    );
    test(
      'link input should open select circle',
      () async {
        // GIVEN
        final input = Stubs.createLinkPostInput;
        when(() => navigator.openSelectCircle(any())).thenAnswer((_) async => {});

        // WHEN
        await presenter.onTapPost(input);

        // THEN
        verify(() => navigator.openSelectCircle(any()));
      },
    );
    test(
      'text input should open select circle',
      () async {
        // GIVEN
        final input = Stubs.createTextPostInput;
        when(() => navigator.openSelectCircle(any())).thenAnswer((_) async => {});

        // WHEN
        await presenter.onTapPost(input);

        // THEN
        verify(() => navigator.openSelectCircle(any()));
      },
    );
  });

  group('tapping on post with preselected circle id', () {
    setUp(() {
      _initMvp(circle: Stubs.circle);
    });

    test(
      'text input create post',
      () async {
        // GIVEN
        final input = Stubs.createTextPostInput;
        when(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput'))).thenAnswer(
          (_) => successFuture(unit),
        );

        // WHEN
        await presenter.onTapPost(input);

        // THEN
        verify(() => PostsMocks.createPostUseCase.execute(createPostInput: any(named: 'createPostInput')));
      },
    );
  });

  setUp(
    () {
      _initMvp();
    },
  );
}
