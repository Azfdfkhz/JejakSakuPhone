import 'package:flutter/material.dart';

/// Vertical line separator
class WidgetDivider extends StatelessWidget {
  const WidgetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: Colors.white.withOpacity(0.3),
    );
  }
}
