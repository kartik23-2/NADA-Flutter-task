import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// A prominent badge displaying mutual connection information or an empty connection indicator.
class ConnectionBadge extends StatelessWidget {
  final String? connectionText;
  final bool isCompact;

  const ConnectionBadge({
    super.key,
    required this.connectionText,
    this.isCompact = true,
  });

  bool get hasConnection =>
      connectionText != null && connectionText!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (hasConnection) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: isCompact ? 10 : 14,
          vertical: isCompact ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.connectionHighlightBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.connectionHighlightBorder,
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Icon(
                Icons.hub_outlined,
                size: isCompact ? 16 : 20,
                color: AppColors.connectionHighlightText,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Connected through',
                    style: TextStyle(
                      fontSize: isCompact ? 11 : 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.connectionHighlightText,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    connectionText!,
                    style: TextStyle(
                      fontSize: isCompact ? 13 : 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Unconnected state
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 14,
        vertical: isCompact ? 6 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.7),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.link_off_rounded,
            size: isCompact ? 14 : 16,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 6),
          Text(
            'No connection yet',
            style: TextStyle(
              fontSize: isCompact ? 12 : 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
