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
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_navigator.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';

class AfterPostDialogPresenter extends Cubit<AfterPostDialogViewModel> {
  AfterPostDialogPresenter(
    super.model,
    this.navigator,
    this._getContactsUseCase,
    this._notifyContactUseCase,
    this._openNativeAppSettingsUseCase,
    this._requestRuntimePermissionUseCase,
    this._uploadContactsUseCase,
    this._getPhoneContactsUseCase,
    this._debouncer,
    this._sharePostUseCase,
    this._logAnalyticsEventUseCase,
  );

  final AfterPostDialogNavigator navigator;
  final GetContactsUseCase _getContactsUseCase;
  final NotifyContactUseCase _notifyContactUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final UploadContactsUseCase _uploadContactsUseCase;
  final GetPhoneContactsUseCase _getPhoneContactsUseCase;
  final Debouncer _debouncer;
  final SharePostUseCase _sharePostUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  AfterPostDialogPresentationModel get _model => state as AfterPostDialogPresentationModel;

  Future<void> onInit() async {
    await _requestContactsPermission();
    await _getPhoneContacts();
  }

  void onTapSharePostLink() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.postShareButton,
      ),
    );
    navigator.shareText(text: _model.shareLink);

    onPostShare();
  }

  void onPostShare() {
    _sharePostUseCase
        .execute(
          postId: _model.post.id,
        )
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (success) => tryEmit(_model.byIncrementingShareCount()),
        );
  }

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
          entityId: _model.post.id,
          notifyType: NotifyType.sharePost,
        )
        .doOn(
          success: (result) => _handleInviteEvent(contact),
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void onTapClose() {
    navigator.close();
  }

  PhoneContact? getContactForUser(UserContact user) => _model.phoneContacts
      .firstWhereOrNull((contact) => contact.phones.map((e) => e.value).contains(user.contactPhoneNumber.number));

  Future<void> _requestContactsPermission() => _requestRuntimePermissionUseCase
      .execute(permission: RuntimePermission.contacts) //
      .doOn(
        success: (status) async {
          tryEmit(
            _model.copyWith(
              permissionStatus: status,
            ),
          );
          await _uploadContacts();
          await loadMoreContacts(fromScratch: true);
        },
        fail: (status) => tryEmit(_model.copyWith(permissionStatus: RuntimePermissionStatus.denied)),
      );

  Future<void> _uploadContacts() async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      await _uploadContactsUseCase.execute();
    }
  }

  void _handleInviteEvent(UserContact userContact) {
    final contacts = _model.userContacts.items;
    final index = contacts.indexWhere((element) => element.id == userContact.id);
    final contact = contacts[index];
    tryEmit(_model.byUpdateInviteAction(contact));
    onPostShare();
  }

  Future<void> _getPhoneContacts() async {
    if (_model.permissionStatus == RuntimePermissionStatus.granted) {
      final contacts = await _getPhoneContactsUseCase.execute();
      tryEmit(_model.copyWith(phoneContacts: contacts));
    }
  }
}
