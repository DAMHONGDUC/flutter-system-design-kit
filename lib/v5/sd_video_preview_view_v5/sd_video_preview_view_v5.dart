import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../sd_preview_media_config_v5/sd_preview_media_config_v5.dart';

class SdVideoPreviewViewV5 extends StatefulWidget {
  final SdPreviewMediaConfigV5 config;

  const SdVideoPreviewViewV5({super.key, required this.config});

  @override
  State<SdVideoPreviewViewV5> createState() => _SdVideoPreviewViewV5State();
}

class _SdVideoPreviewViewV5State extends State<SdVideoPreviewViewV5> {
  late Future<File> _fileFuture;

  @override
  void initState() {
    super.initState();
    _fileFuture = _loadFile(widget.config);
  }

  Future<File> _loadFile(SdPreviewMediaConfigV5 config) async {
    if (config.isAsset) {
      final byteData = await rootBundle.load(config.filePath);
      final tempFile = File(
        '${Directory.systemTemp.path}/${config.filePath.split('/').last}',
      );
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      return tempFile;
    } else {
      return File(config.filePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _fileFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final file = snapshot.data!;
        return _VideoPlayerWidget(file: file);
      },
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final File file;

  const _VideoPlayerWidget({required this.file});

  @override
  State<_VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(widget.file);

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
