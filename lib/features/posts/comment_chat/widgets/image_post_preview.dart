import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ImagePostPreview extends StatelessWidget {
  const ImagePostPreview({Key? key, required this.imageUrl}) : super(key: key);

  final ImageUrl imageUrl;

  static const borderRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    final postHeight = MediaQuery.of(context).size.height / 2.4;
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final blackColor = blackAndWhite.shade900;
    final black20 = blackColor.withOpacity(0.2);
    final black30 = blackColor.withOpacity(0.3);
    final black70 = blackColor.withOpacity(0.7);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: postHeight,
        width: double.infinity,
        child: Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                black70,
                black30,
                black20,
                black30,
                black70,
              ],
            ),
          ),
          child: Image.network(
            imageUrl.url,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
