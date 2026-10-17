import 'package:intl/intl.dart';

class SdDateTimeHelperV5 {
  static String dateTimeToDDMMYY(String? date) {
    if (date == null || date.isEmpty) return '';

    return DateFormat(
      'dd/MM/yyyy',
    ).format(DateTime.tryParse(date) ?? DateTime.now());
  }

  static String dateTimeToHHMMDDMMYY(DateTime date) {
    return DateFormat('HH:mm  dd/MM/yyyy').format(date);
  }

  static String formatDuration(Duration? duration) {
    if (duration == null) {
      return '00:00';
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
