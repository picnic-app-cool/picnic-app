import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/validators/full_name_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late EditProfilePresenter presenter;
  late MockEditProfileNavigator navigator;
  late File? file;

  void _initPresenter({EditProfilePresentationModel? model}) {
    file = File('');
    navigator = MockEditProfileNavigator();
    presenter = EditProfilePresenter(
      model ??
          EditProfilePresentationModel.initial(
            const EditProfileInitialParams(),
            UsernameValidator(),
            FullNameValidator(),
          ).copyWith(
            fullName: 'Test Tester',
          ),
      navigator,
      ProfileMocks.editProfileUseCase,
      Mocks.checkUsernameAvailabilityUseCase,
      Mocks.debouncer,
      ProfileMocks.updateProfileImageUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  }

  test(
    'should enable save button when valid length username entered',
    () {
      presenter.onChangedUsername("danieldd");
      expect(presenter.state.saveEnabled, isTrue);
    },
  );

  test(
    'should disable save button when invalid length username entered',
    () {
      presenter.onChangedUsername("danielddoerthuerds123456789123456");
      expect(presenter.state.saveEnabled, isFalse);
    },
  );

  test(
    'should enable save button when username entered is in lowercase',
    () {
      presenter.onChangedUsername("omar");
      expect(presenter.state.saveEnabled, isTrue);
    },
  );

  test(
    'should show "username cannot be empty" in case of empty username',
    () {
      _initPresenter(
        model: EditProfilePresentationModel.initial(
          EditProfileInitialParams(privateProfile: Stubs.privateProfile),
          UsernameValidator(),
          FullNameValidator(),
        ),
      );
      presenter.onChangedUsername("");
      expect(presenter.state.usernameErrorText, AppLocalizationsEn().usernameEmptyErrorMessage);
    },
  );

  test(
    'should disable save button when username entered is not in lowercase',
    () {
      presenter.onChangedUsername("omarH");
      expect(presenter.state.saveEnabled, isFalse);
    },
  );

  test('tapping back should close the navigator', () {
    // GIVEN
    _initPresenter(
      model: EditProfilePresentationModel.initial(
        EditProfileInitialParams(privateProfile: Stubs.privateProfile),
        UsernameValidator(),
        FullNameValidator(),
      ),
    );
    when(() => navigator.closeWithResult(any())).thenAnswer((_) => unit);

    // WHEN
    presenter.onTapBack();

    // THEN
    verify(() => navigator.closeWithResult(any())).called(1);
  });

  group('profile info changed', () {
    setUp(() {
      _initPresenter(
        model: EditProfilePresentationModel.initial(
          const EditProfileInitialParams(),
          UsernameValidator(),
          FullNameValidator(),
        ).copyWith(bio: 'bio descritpion changed'),
      );
    });

    test('tapping back should show discard confirmation navigator', () {
      // GIVEN
      when(() => navigator.showDiscardProfileInfoChangesRoute(onTapDiscard: any(named: 'onTapDiscard')))
          .thenAnswer((_) => Future.value(true));

      // WHEN
      presenter.onTapBack();

      // THEN
      verify(() => navigator.showDiscardProfileInfoChangesRoute(onTapDiscard: any(named: 'onTapDiscard'))).called(1);
    });

    test('tapping back should not show discard confirmation navigator', () {
      // GIVEN
      when(() => navigator.showDiscardProfileInfoChangesRoute(onTapDiscard: any(named: 'onTapDiscard')))
          .thenAnswer((_) => Future.value(false));

      // WHEN
      presenter.onTapBack();

      // THEN
      verify(() => navigator.showDiscardProfileInfoChangesRoute(onTapDiscard: any(named: 'onTapDiscard'))).called(1);
    });
  });

  test('changing full name should enable save button', () {
    presenter.onChangedFullName('Diones Camargo');
    expect(presenter.state.fullNameChanged, isTrue);
  });

  test('changing bio should enable save button', () {
    presenter.onChangedBio('Bio changed!');
    expect(presenter.state.bioChanged, isTrue);
  });

  group('show image picker', () {
    test('tapping show image picker should open image picker navigator successfully but not update profile yet', () {
      fakeAsync((async) {
        // GIVEN
        when(() => navigator.openImagePicker(any())).thenAnswer((_) async => file);
        when(
          () => navigator.showImageEditor(
            filePath: any(named: 'filePath'),
            forceCrop: any(named: 'forceCrop'),
          ),
        ).thenAnswer((_) => Future.value('path'));

        // WHEN
        presenter.onTapShowImagePicker();
        async.flushMicrotasks();

        // THEN
        verify(
          () => navigator.openImagePicker(any()),
        ).called(1);
        verify(
          () => navigator.showImageEditor(
            filePath: any(named: 'filePath'),
            forceCrop: any(named: 'forceCrop'),
          ),
        ).called(1);
        verifyNever(
          () => ProfileMocks.updateProfileImageUseCase.execute(any()),
        );
      });
    });

    test('tapping show image picker should open image picker navigator and return null', () {
      // GIVEN
      when(() => navigator.openImagePicker(any())).thenAnswer((_) async => null);

      // WHEN
      presenter.onTapShowImagePicker();

      // THEN
      verify(
        () => navigator.openImagePicker(any()),
      ).called(1);
      verifyNever(
        () => navigator.showImageEditor(
          filePath: any(named: 'filePath'),
          forceCrop: any(named: 'forceCrop'),
        ),
      );
      verifyNever(
        () => ProfileMocks.updateProfileImageUseCase.execute(any()),
      );
    });

    test('tapping show image picker should open image picker navigator and return null for show image editor', () {
      fakeAsync((async) {
        // GIVEN
        when(() => navigator.openImagePicker(any())).thenAnswer((_) async => file);
        when(
          () => navigator.showImageEditor(
            filePath: any(named: 'filePath'),
            forceCrop: any(named: 'forceCrop'),
          ),
        ).thenAnswer((_) => Future.value());

        // WHEN
        presenter.onTapShowImagePicker();
        async.flushMicrotasks();

        // THEN
        verify(
          () => navigator.openImagePicker(any()),
        ).called(1);
        verify(
          () => navigator.showImageEditor(
            filePath: any(named: 'filePath'),
            forceCrop: any(named: 'forceCrop'),
          ),
        ).called(1);
        verifyNever(
          () => ProfileMocks.updateProfileImageUseCase.execute(any()),
        );
      });
    });
  });

  setUp(() {
    _initPresenter();
  });
}
