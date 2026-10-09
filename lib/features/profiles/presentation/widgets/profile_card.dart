import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../data/models/profile_model.dart';
import 'connection_badge.dart';

/// Friendzy-styled profile card component using dating app vector assets.
class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onTap,
  });

  bool get isFemale => profile.gender.trim().toUpperCase() == 'F';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepPlum.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          splashColor: AppColors.primary.withValues(alpha: 0.08),
          highlightColor: AppColors.primary.withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Illustrated Avatar with Friendzy story ring + Name & Demographic badges
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with gradient border ring & illustrated profile icon
                    _buildAvatarRing(),
                    const SizedBox(width: 14),

                    // Name, Age and Location
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  profile.name,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    height: 1.25,
                                    letterSpacing: -0.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (profile.degree != null) ...[
                                const SizedBox(width: 6),
                                _buildDegreeBadge(),
                              ],
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Friendzy-styled capsule tags with dating app icons
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _buildPillTag(
                                assetIcon: AppIcons.ageRange,
                                text: '${profile.age} yrs',
                              ),
                              _buildPillTag(
                                assetIcon: AppIcons.gender,
                                text: profile.genderDisplay,
                              ),
                              _buildPillTag(
                                assetIcon: AppIcons.location,
                                text: profile.city,
                                isHighlight: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Trailing action button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),

                // Profession tag if present
                if (profile.profession != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          AppIcons.interests,
                          width: 14,
                          height: 14,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) => const Icon(
                            Icons.work_outline_rounded,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            profile.profession!,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

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
      ),
    );
  }

  Widget _buildAvatarRing() {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.accent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(2.5),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(2),
        child: ClipOval(
          child: Image.asset(
            isFemale ? AppIcons.girl : AppIcons.boy,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: AppColors.accentLight,
              child: Center(
                child: Text(
                  profile.initials,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDegreeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        '${profile.degree}°',
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildPillTag({
    required String assetIcon,
    required String text,
    bool isHighlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: isHighlight
            ? AppColors.primaryLight.withValues(alpha: 0.1)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            assetIcon,
            width: 13,
            height: 13,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => Icon(
              Icons.circle,
              size: 10,
              color: isHighlight ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
              color: isHighlight ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
