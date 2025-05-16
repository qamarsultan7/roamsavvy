import 'package:flutter/material.dart';

class TimeRow extends StatelessWidget {
  final String day;
  final String hours;
  const TimeRow(this.day, this.hours, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
          Text(hours, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
        ],
      ),
    );
  }
}
