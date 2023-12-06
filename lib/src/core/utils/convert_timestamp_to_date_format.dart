import 'package:intl/intl.dart';

String convertTimestampToDateFormat(String timestamp) {
  if (timestamp.isEmpty) {
    return "";
  }
  DateTime dateTime = DateTime.parse(timestamp);

  String formattedDate = DateFormat('d MMM y').format(dateTime);

  return formattedDate;
}

String convertTimestampToDateDMYFormat(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp);

  String formattedDate = DateFormat('d/M/y').format(dateTime);

  return formattedDate;
}
