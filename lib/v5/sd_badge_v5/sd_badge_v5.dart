import 'package:flutter/material.dart';
import '../index.dart';

class SdBadgeV5 extends StatelessWidget {
  final int count;
  final Color badgeColor;
  final Color textColor;
  final double size;

  const SdBadgeV5({
    super.key,
    required this.count,
    this.badgeColor = Colors.red,
    this.textColor = Colors.white,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    // Cap display value
    final displayCount = count > 99 ? '99+' : count.toString();

    return Container(
      constraints: BoxConstraints(minWidth: size, minHeight: size),
      padding: const EdgeInsets.symmetric(horizontal: SdSpacingV5.s6),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      alignment: Alignment.center,
      child: Text(
        displayCount,
        style: SdTextStyleV5.body10().wColor(textColor),
      ),
    );
  }
}
