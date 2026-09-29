import 'package:flutter/material.dart';

import '../../../core/theme/theme.dart';
import '../../companion/companion_data.dart';
import '../../companion/companion_mood.dart';
import '../../companion/companion_renderer.dart';

/// Circle showing the companion. Visual and status dot are driven by
/// [companionData]; no hardcoded "Online" label.
class CompanionCircle extends StatelessWidget {
  const CompanionCircle({super.key, required this.companionData});

  final CompanionData? companionData;

  @override
  Widget build(BuildContext context) {
    final data = companionData ?? CompanionData.idle;
    return SizedBox(
      width: 54,
      height: 54,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          CompanionRenderer(data: data, size: 50, showStatus: false),
          if (data.mood != CompanionMood.offline)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.syncedGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
