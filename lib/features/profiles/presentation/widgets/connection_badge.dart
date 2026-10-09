import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Friendzy-styled connection badge prominently displaying mutual connection pathways.
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
      if (!isCompact) {
        return _buildExpandedBadge();
      }
      return _buildCompactBadge();
    }

    return _buildUnconnectedBadge();
  }

  Widget _buildCompactBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.connectionHighlightBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.connectionHighlightBorder,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_rounded,
              size: 13,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Connected through',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.connectionHighlightText,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  connectionText!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedBadge() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.connectionHighlightBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.connectionHighlightBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          // Visual two-node connection graphic inspired by Friendzy match screen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildConnectionNode(icon: Icons.person_rounded, isUser: true),
              Container(
                width: 44,
                height: 2,
                color: AppColors.primaryLight.withValues(alpha: 0.6),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 44,
                height: 2,
                color: AppColors.primaryLight.withValues(alpha: 0.6),
              ),
              _buildConnectionNode(icon: Icons.diversity_1_rounded, isUser: false),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Mutual Connection Found',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            connectionText!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionNode({required IconData icon, required bool isUser}) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isUser ? AppColors.deepPlum : AppColors.primary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 18,
        color: isUser ? AppColors.deepPlum : AppColors.primary,
      ),
    );
  }

  Widget _buildUnconnectedBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isCompact ? 10 : 14,
        vertical: isCompact ? 6 : 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.explore_outlined,
            size: isCompact ? 14 : 16,
            color: AppColors.textTertiary,
          ),
          const SizedBox(width: 6),
          const Text(
            'No connection yet',
            style: TextStyle(
              fontSize: 12.5,
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
