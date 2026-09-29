import 'package:flutter/material.dart';
import '../../../core/theme/theme.dart';
import 'package:intl/intl.dart';

/// Rounded rectangle showing current date/day
class DatePill extends StatelessWidget {
  final DateTime date;

  const DatePill({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.date,
        borderRadius: BorderRadius.circular(AppRadius.datePill),
      ),
      child: Text(
        DateFormat('dd/MM').format(date),
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
