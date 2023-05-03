import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/notify_type.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/model/user_contact.dart';
import 'package:picnic_app/core/domain/use_cases/get_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_phone_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/notify_contact_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart';
import 'package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';

class CircleCreationSuccessPresenter extends Cubit<CircleCreationSuccessViewModel> {
  CircleCreationSuccessPresenter(
    CircleCreationSuccessPresentationModel model,
    this.navigator,
    this._getContactsUseCase,
    this._requestRuntimePermissionUseCase,
    this._openNativeAppSettingsUseCase,
    this._notifyContactUseCase,
    this._getPhoneContactsUseCase,
    this._createPostUseCase,
    this._debouncer,
  ) : super(model);

  final CircleCreationSuccessNavigator navigator;
  final GetContactsUseCase _getContactsUseCase;

  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final NotifyContactUseCase _notifyContactUseCase;
  final GetPhoneContactsUseCase _getPhoneContactsUseCase;
  final CreatePostUseCase _createPostUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  CircleCreationSuccessPresentationModel get _model => state as CircleCreationSuccessPresentationModel;

  Future<void> onInit() async {
    await _requestContactsPermission();
    await _getPhoneContacts();
  }

  void onTapShareCircleLink() => navigator.shareText(text: _model.circleShareLink);

  Future<void> loadMoreContacts({bool fromScratch = false}) async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      final cursor = fromScratch ? const Cursor.firstPage() : _model.userContacts.nextPageCursor();

      await _getContactsUseCase
          .execute(
        nextPageCursor: cursor,
        searchQuery: _model.query,
      )
          .observeStatusChanges(
        (result) {
          tryEmit(_model.copyWith(contactsResult: result));
        },
      ).doOn(
        success: (userContacts) {
          final newList = fromScratch ? userContacts : _model.userContacts + userContacts;
          tryEmit(_model.copyWith(userContacts: newList));
        },
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );
    }
  }

  void onTapInvite(UserContact contact) {
    _notifyContactUseCase
        .execute(
          contactId: contact.id,
          entityId: _model.createPostInput.circleId,
          notifyType: NotifyType.inviteCircle,
        )
        .doOn(
          success: (result) => _handleInviteEvent(contact),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onSearch(String query) {
    if (query == _model.query) {
      return;
    }

    tryEmit(_model.copyWith(query: query));
    _debouncer.debounce(
      const LongDuration(),
      () => loadMoreContacts(fromScratch: true),
    );
  }

  void onTapAllowImportContacts() => _openNativeAppSettingsUseCase.execute();

  Future<void> onTapAwesome() async {
    if (_model.createCircleWithoutPost) {
      navigator.closeUntilMain();
      await navigator.openPrivateProfile(
        const PrivateProfileInitialParams(),
      );
    } else if (_model.createPostInput.circleId.isNone) {
      navigator.closeUntilMain();
    } else {
      await _createPostUseCase.execute(
        createPostInput: _model.createPostInput,
      );
      navigator.closeUntilMain();
    }
  }

  PhoneContact? getContactForUser(UserContact user) => _model.phoneContacts
      .firstWhereOrNull((contact) => contact.phones.map((e) => e.value).contains(user.contactPhoneNumber.number));

  void _handleInviteEvent(UserContact userContact) {
    final contacts = _model.userContacts.items;
    final index = contacts.indexWhere((element) => element.id == userContact.id);
    final contact = contacts[index];
    tryEmit(_model.byUpdateInviteAction(contact));
  }

  Future<void> _requestContactsPermission() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.contacts) //
      .doOn(
        success: (status) => tryEmit(_model.copyWith(permissionStatus: status)),
      );

  Future<void> _getPhoneContacts() async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      final contacts = await _getPhoneContactsUseCase.execute();
      tryEmit(_model.copyWith(phoneContacts: contacts));
    }
  }
}
