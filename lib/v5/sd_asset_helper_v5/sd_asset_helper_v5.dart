import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../index.dart';

class SdAssetHelperV5 {
  static Future<SdAssetVideoMetadataV5> getVideoMetadataFromAsset({
    required String videoPath,
  }) async {
    final byteData = await rootBundle.load(videoPath);
    final Directory tempDir = await getTemporaryDirectory();

    final File tempVideoFile = File('${tempDir.path}/$videoPath')
      ..createSync(recursive: true)
      ..writeAsBytesSync(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );

    final videoThumbnail = await getLocalVideoThumbnail(file: tempVideoFile);
    final videoDuration = await getLocalVideoDuration(file: tempVideoFile);

    return SdAssetVideoMetadataV5(
      videoPath: videoPath,
      tempFile: tempVideoFile,
      duration: videoDuration,
      thumbnailPath: videoThumbnail,
    );
  }

  static Future<Duration?> getLocalVideoDuration({required File file}) async {
    final controller = VideoPlayerController.file(file);

    try {
      await controller.initialize(); // loads metadata
      return controller.value.duration;
    } catch (e) {
      debugPrint('Error getting video duration: $e');
      return null;
    } finally {
      await controller.dispose();
    }
  }

  static Future<String?> getLocalVideoThumbnail({
    required File file,
    int quality = 50,
  }) async {
    try {
      return await VideoThumbnail.thumbnailFile(
        video: file.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        quality: quality,
      );
    } catch (e, st) {
      SdLogV5.e('Error getVideoThumbnailFromAsset', e);
      SdLogV5.e('StackTrace', st);
      return null;
    }
  }
}
