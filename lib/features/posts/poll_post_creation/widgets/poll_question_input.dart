import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/suggestion_list/picnic_suggested_user_typing_component.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PollQuestionInput extends StatefulWidget {
  const PollQuestionInput({
    super.key,
    required this.onChanged,
    required this.suggestedUsersToMention,
    required this.onTapSuggestedMention,
    required this.profileStats,
    required this.isMentionsPollPostCreationEnabled,
  });

  final ValueChanged<String> onChanged;
  final PaginatedList<UserMention> suggestedUsersToMention;
  final ValueChanged<UserMention>? onTapSuggestedMention;
  final ProfileStats? profileStats;
  final bool isMentionsPollPostCreationEnabled;

  @override
  State<PollQuestionInput> createState() => _PollQuestionInputState();
}

class _PollQuestionInputState extends State<PollQuestionInput> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return PicnicSuggestedUserTypingComponent(
      textEditingController: widget.isMentionsPollPostCreationEnabled ? _textEditingController : null,
      suggestedUsersToMention: widget.suggestedUsersToMention,
      onTapSuggestedMention: widget.onTapSuggestedMention,
      profileStats: widget.profileStats,
      compositedChild: PicnicTextInput(
        textController: _textEditingController,
        hintText: appLocalizations.askAQuestionHint,
        onChanged: widget.onChanged,
        padding: 0,
        inputFillColor: colors.blackAndWhite.shade200,
      ),
    );
  }
}
