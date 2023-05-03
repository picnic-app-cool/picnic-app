// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presentation_model.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_presenter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PhotoEditorPage extends StatefulWidget with HasPresenter<PhotoEditorPresenter> {
  const PhotoEditorPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PhotoEditorPresenter presenter;

  @override
  State<PhotoEditorPage> createState() => _PhotoEditorPageState();
}

class _PhotoEditorPageState extends State<PhotoEditorPage>
    with PresenterStateMixin<PhotoEditorViewModel, PhotoEditorPresenter, PhotoEditorPage> {
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
                  "Pick an image to edit",
                  textAlign: TextAlign.center,
                  style: PicnicTheme.of(context).styles.title40,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: presenter.onTapPickImage,
                  child: const Text("Pick image from gallery"),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
}
