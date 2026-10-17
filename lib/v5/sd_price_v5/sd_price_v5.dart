import 'package:flutter/material.dart';

import '../../core/sd_spacing_constant.dart';
import '../sd_context_v5/sd_context_v5.dart';
import '../sd_text_style_v5/sd_text_style_v5.dart';

/// How large a price is set.
enum SdPriceSizeV5 { small, medium, large }

/// A price, and the struck compare-at price beside it when on sale.
///
/// Takes both figures already formatted: currency is the app's business, and
/// a widget that formatted money would have to know the locale's rules.
class SdPriceV5 extends StatelessWidget {
  const SdPriceV5({
    required this.price,
    this.compareAt,
    this.size = SdPriceSizeV5.medium,
    super.key,
  });

  final String price;
  final String? compareAt;
  final SdPriceSizeV5 size;

  @override
  Widget build(BuildContext context) {
    final TextStyle main = switch (size) {
      SdPriceSizeV5.small => context.textTheme5.titleSmall!,
      SdPriceSizeV5.medium => context.textTheme5.titleMedium!,
      SdPriceSizeV5.large => context.textTheme5.headlineSmall!,
    };
    final bool onSale = compareAt != null;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: SdSpacingConstant.w6,
      children: <Widget>[
        Text(
          price,
          style: main.bold5.tabular5.copyWith(
            color: onSale
                ? context.sdTheme5.accent
                : context.sdTheme5.textPrimary,
          ),
        ),
        if (onSale)
          Padding(
            padding: EdgeInsets.only(bottom: SdSpacingConstant.h2),
            child: Text(
              compareAt!,
              style: context.textTheme5.bodySmall!.struck5.tabular5.copyWith(
                color: context.sdTheme5.textTertiary,
              ),
            ),
          ),
      ],
    );
  }
}
