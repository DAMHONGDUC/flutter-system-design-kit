import 'dart:io';
import 'package:equatable/equatable.dart';

class SdAssetVideoMetadataV5 extends Equatable {
  final File? tempFile;
  final Duration? duration;
  final String videoPath;
  final String? thumbnailPath;

  const SdAssetVideoMetadataV5({
    this.tempFile,
    this.duration,
    required this.videoPath,
    this.thumbnailPath,
  });

  factory SdAssetVideoMetadataV5.init(String videoPath) {
    return SdAssetVideoMetadataV5(
      tempFile: null,
      duration: null,
      videoPath: videoPath,
      thumbnailPath: null,
    );
  }

  SdAssetVideoMetadataV5 copyWith({
    File? tempFile,
    Duration? duration,
    String? videoPath,
    String? thumbnailPath,
  }) {
    return SdAssetVideoMetadataV5(
      tempFile: tempFile ?? this.tempFile,
      duration: duration ?? this.duration,
      videoPath: videoPath ?? this.videoPath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
    );
  }

  @override
  List<Object?> get props => [tempFile, duration, videoPath, thumbnailPath];
}
