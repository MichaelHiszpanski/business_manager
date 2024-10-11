import 'package:intl/intl.dart';

class DateFormatHelper {
  static String dateFomrat(DateTime? date) {
    if (date == null) return "No Expiration Date.";

    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }
}
