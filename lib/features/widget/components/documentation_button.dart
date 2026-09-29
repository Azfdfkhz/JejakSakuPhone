import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';

/// Action button for documentation
class DocumentationButton extends StatelessWidget {
  final VoidCallback? onTap;

  const DocumentationButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.documentationButton),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.documentation,
            borderRadius: BorderRadius.circular(AppRadius.documentationButton),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.camera_alt, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                AppStrings.documentation,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
