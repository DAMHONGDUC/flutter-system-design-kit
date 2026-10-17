import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../index.dart';

class SdHelperV5 {
  static void showSelectBottomSheet<T>({
    required BuildContext context,
    required List<T> data,
    required String Function(T data) itemLabelBuilder,
    String? title,
    void Function(T selected)? onSelected,
    Color? bgColor,
    Color? textColor,
  }) {
    final borderRadius = BorderRadius.only(
      topLeft: Radius.circular(SdSpacingV5.s10),
      topRight: Radius.circular(SdSpacingV5.s10),
    );

    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SdBottomSheetV5(
          title: title,
          bgColor: bgColor,
          textColor: textColor,
          borderRadius: borderRadius,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = data[index];

              return SdInkWellV5(
                borderRadius: 0,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: SdSpacingV5.s16,
                  vertical: SdSpacingV5.s12,
                ),
                onTap: () {
                  onSelected?.call(item);
                  Navigator.of(context).pop();
                },
                child: Text(
                  itemLabelBuilder(item),
                  style: SdTextStyleV5.body12().copyWith(color: textColor),
                ),
              );
            },
            itemCount: data.length,
          ),
        );
      },
    );
  }

  static Future<void> delay({
    int milliseconds = 500,
    void Function()? action,
  }) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds), action);
  }

  static Future<void> delayLoading({int min = 1, int max = 3}) async {
    await Future<void>.delayed(
      Duration(
        seconds: randomInt(min: min, max: max),
      ),
    );
  }

  static bool isAmountOverLimit(String value, {int? limit}) {
    final cleaned = value.replaceAll(',', '');
    final numValue = double.tryParse(cleaned) ?? 0;

    return numValue > (limit ?? SdConstantsV5.limitAmount);
  }

  static double randomDouble({double min = 1.0, double max = 5.0}) {
    final random = Random();
    final value = random.nextDouble() * (max - min) + min;
    return double.parse(value.toStringAsFixed(1));
  }

  static int randomInt({int min = 1, int max = 5}) {
    final random = Random();
    return random.nextInt(max - min + 1) + min;
  }

  static IconData getAppBarBackIcon() {
    return Platform.isAndroid
        ? Icons.arrow_back
        : Symbols.arrow_back_ios_new_rounded;
  }

  static EdgeInsets getPageDefaultPadding() {
    return const EdgeInsets.symmetric(
      horizontal: SdSpacingV5.s16,
      vertical: SdSpacingV5.s12,
    );
  }
}
