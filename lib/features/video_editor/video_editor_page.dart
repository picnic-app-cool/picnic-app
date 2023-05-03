// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/video_editor/video_editor_presentation_model.dart';
import 'package:picnic_app/features/video_editor/video_editor_presenter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class VideoEditorPage extends StatefulWidget with HasPresenter<VideoEditorPresenter> {
  const VideoEditorPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final VideoEditorPresenter presenter;

  @override
  State<VideoEditorPage> createState() => _VideoEditorPageState();
}

class _VideoEditorPageState extends State<VideoEditorPage>
    with PresenterStateMixin<VideoEditorViewModel, VideoEditorPresenter, VideoEditorPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Video editor sample page",
                  textAlign: TextAlign.center,
                  style: PicnicTheme.of(context).styles.title40,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: presenter.onTapEditVideo,
                  child: const Text("# Edit Video"),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
}
