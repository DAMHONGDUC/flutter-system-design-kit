import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../index.dart';

class SdCurrencyFormatHelperV5 {
  static String cleanString(String amount) {
    return amount.replaceAll(',', '');
  }

  static String formatCurrencyFromDouble(double amount) {
    final CurrencyFormat settings = CurrencyFormat(
      code: '',
      symbol: '',
      symbolSide: SymbolSide.none,
      thousandSeparator: ',',
      decimalSeparator: '.',
      symbolSeparator: ' ',
    );

    final String result = CurrencyFormatter.format(amount, settings);

    if (result.contains('.') && result.endsWith('0')) {
      return result.substring(0, result.length - 1);
    }

    return result;
  }

  static TextInputFormatter intFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final isNumeric = RegExp(r'^\d*$');
      if (isNumeric.hasMatch(newValue.text)) {
        return newValue;
      }
      return oldValue;
    });
  }

  static TextInputFormatter limitFormatter({
    int? limit,
    required void Function(bool showError) onErrorChanged,
    required bool currentErrorState,
  }) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final isOverLimit = SdHelperV5.isAmountOverLimit(
        newValue.text,
        limit: limit,
      );

      if (isOverLimit) {
        if (!currentErrorState) {
          onErrorChanged(true);
        }
        return oldValue;
      }

      if (currentErrorState) {
        onErrorChanged(false);
      }

      return newValue;
    });
  }

  static TextInputFormatter amountFormatter() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      final text = newValue.text;
      final isValid = RegExp(r'^[0-9.,]*$').hasMatch(text);

      if (!isValid ||
          text.endsWith(',') ||
          text.endsWith('.0') ||
          text.endsWith('..')) {
        return oldValue;
      }

      if (text.endsWith('.')) return newValue;

      if (text.contains('.')) {
        final parts = text.split('.');
        if (parts.length > 1 && parts[1].length > 2) {
          return oldValue;
        }
      }

      final String cleanText = newValue.text.replaceAll(',', '');

      if (cleanText.isEmpty) {
        return newValue.copyWith(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );
      }

      final double? value = double.tryParse(cleanText);
      if (value == null) {
        return oldValue;
      }

      // Format the value
      final String newText = SdCurrencyFormatHelperV5.formatCurrencyFromDouble(
        value,
      );

      // Calculate the new cursor position
      int newCursorPosition =
          newText.length - (cleanText.length - newValue.selection.end);

      // Make sure the cursor is in bounds
      newCursorPosition = newCursorPosition.clamp(0, newText.length);

      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newCursorPosition),
      );
    });
  }

  static String formatPrice(
    num price, {
    String locale = 'en_US',
    String symbol = '\$',
    int decimalDigits = 0,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(price).trim();
  }
}
