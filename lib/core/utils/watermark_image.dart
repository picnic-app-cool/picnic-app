import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as ui;

class WatermarkImage {
  WatermarkImage({
    required this.originalImage,
    required this.watermarkImage,
    required this.text,
  });

  final ui.Image originalImage;
  final ui.Image watermarkImage;
  final String text;
  static const margin = 25;

  /// Add a watermark to an image by specified [originalImage] and [watermarkImage]
  /// The watermark is generated according to the image size (width and height)
  Future<ui.Image> addWatermark() async {
    final textImage = _drawText(
      ui.Image.fromResized(
        watermarkImage,
        width: watermarkImage.width * 2,
        height: watermarkImage.height,
      ),
    );

    final resizedImage = _resizeImage(image: watermarkImage, divisor: 2.5);
    _copyInto(destinationImage: originalImage, sourceImage: resizedImage);
    final resizedText = _resizeImage(image: textImage, divisor: 1.5);
    _copyInto(destinationImage: originalImage, sourceImage: resizedText);

    return originalImage;
  }

  static Future<ui.Image> decodeFileFromIsolate(File file) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _decodeFileIsolate,
      DecodeParam(file: file, sendPort: receivePort.sendPort),
    );
    final originalImage = await receivePort.first as ui.Image;
    return originalImage;
  }

  static Future<File> decodeImageFromIsolate(ui.Image image, File file) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _decodeImageIsolate,
      DecodeParam(
        image: image,
        file: file,
        sendPort: receivePort.sendPort,
      ),
    );
    final originalImage = await receivePort.first as File;
    return originalImage;
  }

  ui.Image _resizeImage({
    required ui.Image image,
    required double divisor,
  }) {
    return ui.copyResize(
      image,
      width: originalImage.width ~/ divisor,
      interpolation: ui.Interpolation.linear,
    );
  }

  ui.Image _drawText(ui.Image textImage) {
    const widthDivisor = 2.5;
    const heightDivisor = 3.6;

    return ui.drawString(
      textImage,
      text,
      font: ui.arial48,
      x: textImage.width - margin ~/ widthDivisor,
      y: textImage.height - watermarkImage.height ~/ heightDivisor,
      rightJustify: true,
    );
  }

  /// Copy a watermark image inside the original image
  ui.Image _copyInto({
    required ui.Image destinationImage,
    required ui.Image sourceImage,
  }) =>
      ui.compositeImage(
        destinationImage,
        sourceImage,
        dstX: destinationImage.width - sourceImage.width - margin,
        dstY: destinationImage.height - sourceImage.height - margin,
      );

  /// Decode an image to [ui.Image] object in an Isolate
  static Future<void> _decodeFileIsolate(DecodeParam param) async {
    final decodedImage = ui.decodeImage(param.file.readAsBytesSync())!;
    param.sendPort.send(decodedImage);
  }

  /// Decode an image to [ui.Image] object in an Isolate
  static Future<void> _decodeImageIsolate(DecodeParam param) async {
    final decodedImage = await param.file.writeAsBytes(ui.encodePng(param.image!));
    param.sendPort.send(decodedImage);
  }
}

class DecodeParam {
  DecodeParam({
    this.image,
    required this.file,
    required this.sendPort,
  });

  final ui.Image? image;
  final File file;
  final SendPort sendPort;
}
