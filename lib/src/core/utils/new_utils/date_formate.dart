import 'package:intl/intl.dart';

abstract class DateFormatter {
  String get format;

  bool useEnglishOnly = false;

  String fromDate(DateTime dateTime) {
    String requiredDateInOldLanguage;
    try {
      requiredDateInOldLanguage = DateFormat(format, "en").format(dateTime);
    } catch (e) {
      requiredDateInOldLanguage = DateFormat(format, "en").format(dateTime);
    }

    return requiredDateInOldLanguage;
  }
}

class DayNameFormat extends DateFormatter {
  @override
  String get format => 'EEE';
}

String formatTimeToAmPm(String timeString) {
  final inputFormat = DateFormat('HH:mm:ss' , "en");
  final outputFormat = DateFormat('h:mm a' , "en");
  final DateTime dateTime = inputFormat.parse(timeString);
  return outputFormat.format(dateTime);
}

String formatDay(String dateString) {
  final inputFormat = DateFormat('dd-MM-yyyy' , "en");
  final outputFormat = DateFormat('d' ,  "en");
  final DateTime dateTime = inputFormat.parse(dateString);
  return outputFormat.format(dateTime);
}

String formatMonthToShort(String monthString) {
  final inputFormat = DateFormat('MMMM');
  final outputFormat = DateFormat('MMM');
  final DateTime dateTime = inputFormat.parse(monthString);
  return outputFormat.format(dateTime);
}

String formatDateToCustomFormat(String dateString) {
  final parts = dateString.split(RegExp(r'[-/ ]'));

  if (parts.length < 3) {
    return '';
  }

  final year = int.tryParse(parts[2]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[0]);

  if (year == null || month == null || day == null) {
    return '';
  }

  final DateTime dateTime = DateTime(year, month, day);
  final dayName = DateFormat('E').format(dateTime); // 'E' represents the abbreviated day name
  return dayName;
}

String dateFormat(DateTime inputDate){
  String formattedDate = DateFormat('MM-dd-yyyy').format(inputDate);
  return formattedDate;
}
String dateFormatRequest(DateTime inputDate){
  String formattedDate = DateFormat('yyyy-MM-dd').format(inputDate);
  return formattedDate;
}





