import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';
import 'package:picnic_app/features/media_picker/utils/media_source_type.dart';
import 'package:picnic_app/features/media_picker/widgets/media_grid.dart';
import 'package:picnic_app/features/media_picker/widgets/media_picker_permission_denied.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class MediaPicker extends StatefulWidget with HasPresenter<MediaPickerPresenter> {
  const MediaPicker({
    required this.presenter,
    required this.isVisible,
    this.clearSelected = false,
    super.key,
  });

  @override
  final MediaPickerPresenter presenter;

  final bool isVisible;
  final bool clearSelected;

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker>
    with PresenterStateMixin<MediaPickerViewModel, MediaPickerPresenter, MediaPicker> {
  static const double indicatorHeight = 3;
  static const double indicatorWidth = 24;
  static const double unselectedTabOpacity = 0.4;
  static const Color indicatorColor = Color(0xFF2B3F6C);
  static const double indicatorBorderRadius = 3;

  @override
  void didUpdateWidget(MediaPicker oldWidget) {
    if (widget.isVisible) {
      presenter.onOpenAttachments();
    } else {
      if (widget.clearSelected) {
        presenter.clearSelectedAttachments();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final white = PicnicTheme.of(context).colors.blackAndWhite.shade100;
    return stateObserver(
      builder: (context, state) {
        return Visibility(
          visible: widget.isVisible,
          child: Flexible(
            child: ColoredBox(
              color: white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 2),
                    child: Row(
                      children: state.menuIcons
                          .mapIndexed(
                            (index, img) => Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () => presenter.onTapMenuItem(index),
                                child: AnimatedOpacity(
                                  duration: const MediumDuration(),
                                  opacity: state.currentIndex == index ? 1 : unselectedTabOpacity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(img.path),
                                      const Gap(8),
                                      AnimatedContainer(
                                        duration: const MediumDuration(),
                                        height: indicatorHeight,
                                        width: state.currentIndex == index ? indicatorWidth : 0,
                                        decoration: BoxDecoration(
                                          color: indicatorColor,
                                          borderRadius: BorderRadius.circular(indicatorBorderRadius),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: state.permisionRequested.isPending()
                        ? const Center(child: PicnicLoadingIndicator())
                        : state.allNecessaryPermissionsGranted
                            ? MediaGrid(
                                attachments: state.attachments,
                                selectedAttachments: state.selectedAttachments,
                                onTap: presenter.onTapAttachment,
                                loadMore: presenter.loadMoreAttachments,
                              )
                            : AnimatedSwitcher(
                                duration: const MediumDuration(),
                                child: MediaPickerPermissionDenied(
                                  key: ValueKey(state.currentIndex),
                                  mediaSourceType: MediaSourceType.from(state.currentIndex),
                                  onSettingsTap: presenter.onTapOpenSettings,
                                  microphonePermissionGranted: state.microphonePermissionGranted,
                                  cameraPermissionGranted: state.cameraPermissionGranted,
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
