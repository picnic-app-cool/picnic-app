import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_page.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../feed_tests_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late PostCreationIndexPage page;
  late PostCreationIndexInitialParams initParams;
  late PostCreationIndexPresentationModel model;
  late PostCreationIndexPresenter presenter;
  late PostCreationIndexNavigator navigator;

  final flags = Stubs.featureFlags
      .enable(FeatureFlagType.linkPostCreationEnabled)
      .enable(FeatureFlagType.imagePostCreationEnabled)
      .enable(FeatureFlagType.pollPostCreationEnabled)
      .enable(FeatureFlagType.textPostCreationEnabled)
      .enable(FeatureFlagType.videoPostCreationEnabled);

  void _initMvp({
    required FeatureFlags featureFlags,
    PostCreationPreviewType? selectedType,
  }) {
    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.camera))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));
    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.microphone))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));
    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.contacts))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));
    when(() => Mocks.featureFlagsStore.featureFlags).thenReturn(
      featureFlags,
    );
    when(() => Mocks.requestRuntimePermissionUseCase.execute(permission: RuntimePermission.gallery))
        .thenAnswer((invocation) => successFuture(RuntimePermissionStatus.granted));

    when(() => Mocks.getPhoneGalleryAssetsUseCase.execute(nextPageCursor: const PaginatedList.empty().nextPageCursor()))
        .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(() => Mocks.uploadContactsUseCase.execute()).thenAnswer((invocation) => successFuture(unit));

    mockCameraController();

    initParams = const PostCreationIndexInitialParams();
    model = PostCreationIndexPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
    ).copyWith(type: selectedType);
    navigator = PostCreationIndexNavigator(Mocks.appNavigator);
    presenter = PostCreationIndexPresenter(
      model,
      navigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.uploadContactsUseCase,
      PostsMocks.createPostUseCase,
    );
    page = PostCreationIndexPage(
      presenter: presenter,
    );
  }

  await screenshotTest(
    "post_creation_index_page",
    variantName: "all_types",
    setUp: () async {
      _initMvp(featureFlags: flags);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "post_creation_index_page",
    variantName: "image",
    setUp: () async {
      _initMvp(featureFlags: flags, selectedType: PostCreationPreviewType.image);
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "post_creation_index_page",
    variantName: "missing_upload_and_video",
    setUp: () async {
      final flags = Stubs.featureFlags
          .enable(FeatureFlagType.linkPostCreationEnabled)
          .enable(FeatureFlagType.imagePostCreationEnabled)
          .enable(FeatureFlagType.pollPostCreationEnabled)
          .enable(FeatureFlagType.textPostCreationEnabled);

      _initMvp(
        featureFlags: flags,
      );
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "post_creation_index_page",
    variantName: "all_types",
    setUp: () async {
      _initMvp(
        featureFlags: flags,
      );
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp(featureFlags: flags);
    final page = getIt<PostCreationIndexPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
