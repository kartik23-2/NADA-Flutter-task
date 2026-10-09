import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/profile_model.dart';
import 'connection_badge.dart';

/// Card component representing a single matrimonial profile in the feed.
class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryLight.withValues(alpha: 0.08),
        highlightColor: AppColors.primaryLight.withValues(alpha: 0.04),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row: Avatar, Name & Location metadata, Trailing arrow
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Initials Avatar
                  _buildAvatar(context),
                  const SizedBox(width: 14),

                  // Name & essential details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                profile.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                  height: 1.25,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (profile.degreeDisplay != null) ...[
                              const SizedBox(width: 6),
                              _buildDegreeBadge(),
                            ],
                          ],
                        ),
                        const SizedBox(height: 5),

                        // Demographic tags: Age, Gender, City
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            _buildInfoPill(
                              icon: Icons.cake_outlined,
                              text: '${profile.age} yrs',
                            ),
                            _buildDotSeparator(),
                            _buildInfoPill(
                              icon: Icons.person_outline,
                              text: profile.genderDisplay,
                            ),
                            _buildDotSeparator(),
                            _buildInfoPill(
                              icon: Icons.location_on_outlined,
                              text: profile.city,
                              highlight: true,
                            ),
                          ],
                        ),

                        // Profession line if available
                        if (profile.profession != null) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.work_outline_rounded,
                                size: 14,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  profile.profession!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textTertiary,
                    size: 22,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Prominent Connection Badge
              ConnectionBadge(
                connectionText: profile.connectedThrough,
                isCompact: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          profile.initials,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildDegreeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.3),
          width: 0.8,
        ),
      ),
      child: Text(
        '${profile.degree}°',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.connectionHighlightText,
        ),
      ),
    );
  }

  Widget _buildInfoPill({
    required IconData icon,
    required String text,
    bool highlight = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: highlight ? AppColors.primary : AppColors.textTertiary,
        ),
        const SizedBox(width: 3),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
            color: highlight ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDotSeparator() {
    return const Text(
      '•',
      style: TextStyle(
        fontSize: 11,
        color: AppColors.textTertiary,
      ),
    );
  }
}
