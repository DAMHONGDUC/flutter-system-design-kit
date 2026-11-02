import 'package:flutter/material.dart';
import '../sd_image_v5/sd_image_v5.dart';

import '../sd_preview_media_config_v5/sd_preview_media_config_v5.dart';

class SdImagePreviewViewV5 extends StatelessWidget {
  final SdPreviewMediaConfigV5 config;

  const SdImagePreviewViewV5({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    if (config.isAsset) {
      return SdImageV5(imagePath: config.filePath);
    }
    return SizedBox.shrink();
  }
}
