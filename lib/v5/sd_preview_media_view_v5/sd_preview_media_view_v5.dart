import 'package:flutter/material.dart';
import '../index.dart';

class SdPreviewMediaViewV5 extends StatefulWidget {
  final List<SdPreviewMediaConfigV5> items;
  final int initialIndex;

  const SdPreviewMediaViewV5({
    super.key,
    required this.items,
    this.initialIndex = 0,
  });

  static void show({
    required BuildContext context,
    required List<SdPreviewMediaConfigV5> items,
    int initialIndex = 0,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SdPreviewMediaViewV5(items: items, initialIndex: initialIndex);
      },
    );
  }

  @override
  State<SdPreviewMediaViewV5> createState() => _SdPreviewMediaViewV5State();
}

class _SdPreviewMediaViewV5State extends State<SdPreviewMediaViewV5> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = SdColorsV5.black;

    return SdAdaptiveStatusBarV5(
      backgroundColor: bgColor,
      child: Container(
        color: bgColor,
        padding: EdgeInsets.only(
          top: kToolbarHeight,
          bottom: kBottomNavigationBarHeight,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    icon: SdIconV5(
                      iconData: Icons.close,
                      color: SdColorsV5.white,
                    ),
                  ),
                ),
                Text(
                  '${_currentIndex + 1}/${widget.items.length}',
                  style: SdTextStyleV5.body14().wSemiBold().wColor(
                    SdColorsV5.white,
                  ),
                ),
              ],
            ),
            SdVerticalSpacingV5(xRatio: 2),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.items.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (_, index) {
                  final item = widget.items[index];
                  return Center(
                    child: item.isVideo
                        ? SdVideoPreviewViewV5(config: item)
                        : SdImagePreviewViewV5(config: item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
