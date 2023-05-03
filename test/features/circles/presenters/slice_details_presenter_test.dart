import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/domain/model/slice_details_tab.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presenter.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late SliceDetailsPresentationModel model;
  late SliceDetailsPresenter presenter;
  late MockSliceDetailsNavigator navigator;

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.currentTimeProvider.currentTime).thenAnswer((_) => Stubs.dateTime);
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    model = SliceDetailsPresentationModel.initial(
      SliceDetailsInitialParams(
        circle: Stubs.circle.copyWith(name: '#roblox', id: Stubs.circle.id),
        slice: Stubs.slice.copyWith(role: SliceRole.owner),
      ),
    );

    registerFallbackValue(SliceSettingsInitialParams(circle: Stubs.circle, slice: Stubs.slice));
    navigator = MockSliceDetailsNavigator();
    presenter = SliceDetailsPresenter(
      model,
      Mocks.getSliceMemberByRoleUseCase,
      navigator,
      Mocks.clipboardManager,
      Mocks.debouncer,
    );
  });

  test(
    'tapping on a user should open profile',
    () {
      //GIVEN
      when(() => navigator.openProfile(userId: Stubs.publicProfile.id)).thenAnswer((_) => Future.value());
      //WHEN
      presenter.onTapMember(Stubs.sliceMember);

      //THEN
      verify(() => navigator.openProfile(userId: Stubs.publicProfile.id));
    },
  );

  test('tapping on more should open slice bottom sheet', () async {
    //GIVEN
    when(
      () => navigator.openSliceSettingsBottomSheet(any()),
    ).thenAnswer((_) => Future.value(SliceSettingsPageResult.didLeftSlice));

    //WHEN
    await presenter.onTapMore();

    //THEN
    verify(
      () => navigator.openSliceSettingsBottomSheet(any()),
    );
    verify(
      () => navigator.closeWithResult(SliceSettingsPageResult.didLeftSlice),
    );
  });

  test(
    'tapping on tab should change current tab to selected one',
    () {
      // GIVEN
      const selectedTab = 1;

      // WHEN
      presenter.onTabChanged(selectedTab);

      // THEN
      expect(presenter.state.selectedTab, SliceDetailsTab.circleInfo);
    },
  );

  test(
    'tapping on a report to circle owners should open report circle form',
    () {
      //GIVEN
      when(
        () => navigator.openReportForm(any()),
      ).thenAnswer((_) => Future.value(true));

      //WHEN
      presenter.onTapReportToCircleOwners();

      // THEN
      verify(
        () => navigator.openReportForm(any()),
      );
    },
  );

  test(
    'tapping on edit rules should open edit slice rules',
    () {
      //GIVEN
      when(
        () => navigator.openEditSliceRules(any()),
      ).thenAnswer((_) => Future.value(Stubs.slice));

      //WHEN
      presenter.onTapEditRules();

      // THEN
      verify(
        () => navigator.openEditSliceRules(any()),
      );
    },
  );

  test('changing search text should call debouncer and trigger get slice member by role use case ', () async {
    fakeAsync((async) {
      //GIVEN
      const searchQuery = 'query';

      when(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          searchQuery: searchQuery,
          nextPageCursor: const Cursor.firstPage(),
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.member,
          ],
        ),
      ).thenAnswer(
        (_) => successFuture(
          PaginatedList(
            items: [
              Stubs.sliceMember,
            ],
            pageInfo: const PageInfo(
              previousPageId: Id('0'),
              hasPreviousPage: true,
              hasNextPage: true,
              nextPageId: Id('1'),
            ),
          ),
        ),
      );
      when(() => Mocks.debouncer.debounce(const LongDuration(), any())).thenAnswer((invocation) {
        final callback = invocation.positionalArguments[1] as dynamic Function();
        callback();
      });

      //WHEN
      presenter.onSearchTextChanged(searchQuery);

      //THEN
      verify(
        () => Mocks.debouncer.debounce(
          const LongDuration(),
          any(),
        ),
      );

      verify(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          nextPageCursor: const Cursor.firstPage(),
          searchQuery: searchQuery,
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.member,
          ],
        ),
      );
    });
  });

  test(
    'loading more should call slice members of type owner, director and moderator',
    () async {
      when(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          nextPageCursor: any(named: 'nextPageCursor'),
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.owner,
            SliceRole.director,
            SliceRole.moderator,
          ],
        ),
      ).thenAnswer(
        (_) => successFuture(
          PaginatedList(
            items: [
              Stubs.sliceMemberDirector,
            ],
            pageInfo: const PageInfo(
              previousPageId: Id('0'),
              hasPreviousPage: true,
              hasNextPage: true,
              nextPageId: Id('1'),
            ),
          ),
        ),
      );

      // WHEN
      await presenter.loadMoreMembers();

      // THEN
      verify(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          nextPageCursor: any(named: 'nextPageCursor'),
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.owner,
            SliceRole.director,
            SliceRole.moderator,
          ],
        ),
      ).called(1);
    },
  );

  test(
    'loading more should call slice members of type slice member',
    () async {
      presenter.emit(
        model.copyWith(
          users: PaginatedList(
            items: [Stubs.sliceMember],
            pageInfo: const PageInfo(
              previousPageId: Id('0'),
              hasPreviousPage: true,
              hasNextPage: true,
              nextPageId: Id('1'),
            ),
          ),
          moderators: PaginatedList.singlePage(
            [Stubs.sliceMember],
          ),
        ),
      );
      // GIVEN
      when(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          nextPageCursor: any(named: 'nextPageCursor'),
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.member,
          ],
        ),
      ).thenAnswer(
        (_) => successFuture(
          PaginatedList(
            items: [Stubs.sliceMember],
            pageInfo: const PageInfo(
              previousPageId: Id('0'),
              hasPreviousPage: true,
              hasNextPage: true,
              nextPageId: Id('1'),
            ),
          ),
        ),
      );

      // WHEN
      await presenter.loadMoreMembers();

      // THEN
      verify(
        () => Mocks.getSliceMemberByRoleUseCase.execute(
          nextPageCursor: any(named: 'nextPageCursor'),
          sliceId: Stubs.slice.id,
          roles: [
            SliceRole.member,
          ],
        ),
      ).called(1);
    },
  );
}
