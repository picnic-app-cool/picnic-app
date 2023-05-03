import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presenter.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/widgets/director_led_column.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/widgets/invite_friends.dart';
import 'package:picnic_app/ui/widgets/contacts/contacts_list.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';

class CircleCreationSuccessPage extends StatefulWidget with HasPresenter<CircleCreationSuccessPresenter> {
  const CircleCreationSuccessPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CircleCreationSuccessPresenter presenter;

  @override
  State<CircleCreationSuccessPage> createState() => _CircleCreationSuccessPageState();
}

class _CircleCreationSuccessPageState extends State<CircleCreationSuccessPage>
    with
        PresenterStateMixin<CircleCreationSuccessViewModel, CircleCreationSuccessPresenter, CircleCreationSuccessPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    presenter.onInit();
    _controller.addListener(() => presenter.onSearch(_controller.text));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const PicnicBackground(),
          if (state.enableContactSharing)
            stateObserver(
              builder: (context, state) => InviteFriends(
                showContactAccessButton: state.showContactAccessButton,
                onTapLinkBar: presenter.onTapShareCircleLink,
                onTapAwesome: presenter.onTapAwesome,
                onTapAllowImportContacts: presenter.onTapAllowImportContacts,
                controller: _controller,
                contactsList: ContactsList(
                  userContacts: state.userContacts,
                  loadMore: presenter.loadMoreContacts,
                  onTapInvite: presenter.onTapInvite,
                  getContactForUser: presenter.getContactForUser,
                ),
              ),
            )
          else
            DirectorLedColumn(
              onTapLinkBar: presenter.onTapShareCircleLink,
              onTapAwesome: presenter.onTapAwesome,
              circleName: state.circle.name,
              circleShareLink: state.circleShareLink,
            ),
        ],
      ),
    );
  }
}
