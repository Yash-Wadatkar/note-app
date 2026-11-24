import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatShortDate(DateTime date) {
  final now = DateTime.now();
  final daysAgo = DateUtils.dateOnly(
    now,
  ).difference(DateUtils.dateOnly(date)).inDays;

  if (daysAgo == 0) return DateFormat.Hm().format(date);
  if (daysAgo == 1) return 'Yesterday';
  if (date.year == now.year) return DateFormat('d MMM').format(date);
  return DateFormat('d MMM y').format(date);
}

String formatFullDate(DateTime date) {
  return DateFormat('d MMM y, HH:mm').format(date);
}
