import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presenter.dart';
import 'package:picnic_app/features/debug/feature_flags/widgets/feature_flag_item.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';

class FeatureFlagsPage extends StatefulWidget with HasPresenter<FeatureFlagsPresenter> {
  const FeatureFlagsPage({
    super.key,
    required this.presenter,
  });

  @override
  final FeatureFlagsPresenter presenter;

  @override
  State<FeatureFlagsPage> createState() => _FeatureFlagsPageState();
}

class _FeatureFlagsPageState extends State<FeatureFlagsPage>
    with PresenterStateMixin<FeatureFlagsViewModel, FeatureFlagsPresenter, FeatureFlagsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const PicnicAppBar(
          titleText: "Feature flags",
        ),
        body: stateObserver(
          builder: (context, state) => ListView.builder(
            itemCount: state.featureFlags.length,
            itemBuilder: (context, index) => FeatureFlagItem(
              featureFlagType: state.featureFlags[index].key,
              isEnabled: state.featureFlags[index].value,
              onChangeStateTap: presenter.onChangeStateTap,
            ),
          ),
        ),
      );
}
