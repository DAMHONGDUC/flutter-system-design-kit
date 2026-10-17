import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../index.dart';

class SdVideoPlaceHolderV5 extends StatelessWidget {
  final String videoPath;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isAsset;

  const SdVideoPlaceHolderV5({
    super.key,
    required this.videoPath,
    this.width = 80.0,
    this.height = 80.0,
    this.fit = BoxFit.cover,
    this.isAsset = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SdAssetVideoMetadataV5>(
      future: SdAssetHelperV5.getVideoMetadataFromAsset(videoPath: videoPath),
      builder: (context, snapshot) {
        final assetVideoMetadata = snapshot.data;

        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: SdColorsV5.grey,
            borderRadius: BorderRadius.circular(SdSpacingV5.s8),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (assetVideoMetadata?.thumbnailPath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(SdSpacingV5.s8),
                  child: SdImageV5(
                    imagePath: assetVideoMetadata!.thumbnailPath!,
                    width: width,
                    height: height,
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: SdColorsV5.black.withAlpha(100),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(SdSpacingV5.s8),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: SdSpacingV5.s4),
                width: double.infinity,
                height: SdSpacingV5.s24,
                child: Row(
                  children: [
                    SdIconV5(
                      iconData: Symbols.videocam_rounded,
                      iconSize: SdSpacingV5.s18,
                      color: SdColorsV5.white,
                    ),
                    Spacer(),
                    Text(
                      SdDateTimeHelperV5.formatDuration(
                        assetVideoMetadata?.duration,
                      ),
                      style: SdTextStyleV5.body12().wColor(SdColorsV5.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
