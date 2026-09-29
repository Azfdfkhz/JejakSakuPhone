import 'package:flutter/material.dart';

import 'companion_data.dart';
import 'companion_mood.dart';

/// Renders the companion character based on its current state.
///
/// This is the abstraction layer that allows the companion's visual
/// to be swapped out without changing any widget structure. Currently
/// renders placeholder icons — ready for Lottie, Rive, or custom
/// Flutter animations.
///
/// Usage:
/// ```dart
/// CompanionRenderer(
///   data: companionData,
///   size: 50,
/// )
/// ```
class CompanionRenderer extends StatelessWidget {
  const CompanionRenderer({
    super.key,
    required this.data,
    this.size = 50.0,
    this.showStatus = true,
    this.onTap,
  });

  /// The companion's current state data.
  final CompanionData data;

  /// Diameter of the companion circle.
  final double size;

  /// Whether to show status text below the companion.
  final bool showStatus;

  /// Called when the companion is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCircle(),
          if (showStatus && data.statusText != null) ...[
            const SizedBox(height: 4),
            _buildStatusText(),
          ],
        ],
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF9BB8C4), // Slightly darker than widget bg
        border: Border.all(
          color: const Color(0x33FFFFFF),
          width: 1.5,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: _buildPlaceholderContent(),
      ),
    );
  }

  /// Builds placeholder content for the companion.
  ///
  /// This method is the primary replacement point when real
  /// robot assets become available.
  Widget _buildPlaceholderContent() {
    final iconSize = size * 0.45;
    return Icon(
      data.mood.placeholderIcon,
      size: iconSize,
      color: Colors.white,
    );
  }

  Widget _buildStatusText() {
    return SizedBox(
      width: size + 16,
      child: Text(
        data.statusText!,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D3748),
        ),
      ),
    );
  }
}
