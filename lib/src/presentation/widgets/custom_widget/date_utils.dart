import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getTodayDate() {
  return formatDate(DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));
}

String getDateBeforeOneWeek() {
  return formatDate(DateTime.now().subtract(const Duration(days: 7)));
}

String formatDate(DateTime dateTime) {
  return DateFormat("dateFormat", "formatLocal").format(dateTime);
}

String formatFromDate(DateTime? dateTime) {
  if (dateTime == null) {
    return getDateBeforeOneWeek();
  }
  return formatDate(dateTime);
}

String formatToDate(DateTime? dateTime) {
  if (dateTime == null) {
    return getTodayDate();
  }
  return formatDate(dateTime);
}

String formatDateBasedOnLanguage(String date, String language) {
  try {
    DateTime dateTime = DateFormat("dd/MM/yyyy", "en").parse(date);
    return DateFormat("dd-MM-yyyy", Locale(language).toString())
        .format(dateTime);
  } catch (e) {
    return "";
  }
}

String formatDateTime(String date) {
  if (date.isEmpty) return "";
  return DateFormat("dd-MM-yyyy", "en")
      .format(DateTime.parse(date).add(Duration(hours: 3)));
}

String formatDateTimeString(String date) {
  if (date.isEmpty) return "";
  return date.replaceAll("/", "-");
}
