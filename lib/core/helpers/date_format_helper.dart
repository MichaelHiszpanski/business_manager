import 'package:intl/intl.dart';

class DateFormatHelper {
  static String dateFormatWithTime(DateTime? date) {
    if (date == null) return "No Expiration Date and Time.";

    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  static String dateFormat(DateTime? date) {
    if (date == null) return "No Expiration Date.";
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String dateFormatFromString(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) {
      return "No Expiration Date.";
    }

    final date = DateTime.parse(dateStr);
    return DateFormat('yyyy-MM-dd').format(date);
  }
}
