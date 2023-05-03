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
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';

class InviteFriendsBottomSheetPresenter extends Cubit<InviteFriendsBottomSheetViewModel> {
  InviteFriendsBottomSheetPresenter(
    super.model,
    this.navigator,
    this._getContactsUseCase,
    this._notifyContactUseCase,
    this._openNativeAppSettingsUseCase,
    this._requestRuntimePermissionUseCase,
    this._getPhoneContactsUseCase,
    this._debouncer,
  );

  final InviteFriendsBottomSheetNavigator navigator;
  final GetContactsUseCase _getContactsUseCase;
  final NotifyContactUseCase _notifyContactUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final GetPhoneContactsUseCase _getPhoneContactsUseCase;
  final Debouncer _debouncer;

  // ignore: unused_element
  InviteFriendsBottomSheetPresentationModel get _model => state as InviteFriendsBottomSheetPresentationModel;

  Future<void> onInit() async {
    await _requestContactsPermission();
    await _getPhoneContacts();
  }

  void onTapShareLink() => navigator.shareText(text: _model.shareLink);

  void onSearch(String query) {
    if (query == _model.searchQuery) {
      return;
    }

    tryEmit(_model.copyWith(searchQuery: query));
    _debouncer.debounce(
      const LongDuration(),
      () => loadMoreContacts(fromScratch: true),
    );
  }

  void onTapAllowImportContacts() => _openNativeAppSettingsUseCase.execute();

  Future<void> loadMoreContacts({bool fromScratch = false}) async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      final cursor = fromScratch ? const Cursor.firstPage() : _model.userContacts.nextPageCursor();

      await _getContactsUseCase
          .execute(
            nextPageCursor: cursor,
            searchQuery: _model.searchQuery,
          )
          .doOn(
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
          notifyType: NotifyType.inviteFriend,
        )
        .doOn(
          success: (result) => _handleInviteEvent(contact),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapClose() => navigator.close();

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
        fail: (status) => tryEmit(_model.copyWith(permissionStatus: RuntimePermissionStatus.denied)),
      );

  Future<void> _getPhoneContacts() async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      final contacts = await _getPhoneContactsUseCase.execute();
      tryEmit(_model.copyWith(phoneContacts: contacts));
    }
  }
}
