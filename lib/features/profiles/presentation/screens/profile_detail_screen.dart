import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/profile_model.dart';
import '../widgets/connection_badge.dart';

/// Screen displaying the complete profile attributes and prominent connection context.
class ProfileDetailScreen extends StatelessWidget {
  final Profile profile;

  const ProfileDetailScreen({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile Details'),
        elevation: 0,
        backgroundColor: AppColors.surface,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Profile Header Card
            _buildHeroHeader(context),
            const SizedBox(height: 16),

            // Prominent Mutual Connection Banner
            _buildConnectionBanner(context),
            const SizedBox(height: 16),

            // About Section (if present)
            if (profile.about != null && profile.about!.trim().isNotEmpty) ...[
              _buildAboutSection(context),
              const SizedBox(height: 16),
            ],

            // Attributes and Background Details
            _buildDetailsCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Initials Avatar
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryLight,
                  AppColors.primary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                profile.initials,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Name (supports long multi-line names without overflow)
          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 1.25,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Age, Gender, City badges
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(
                icon: Icons.cake_outlined,
                label: '${profile.age} years old',
              ),
              _buildChip(
                icon: Icons.person_outline,
                label: profile.genderDisplay,
              ),
              _buildChip(
                icon: Icons.location_on_outlined,
                label: profile.city,
                highlight: true,
              ),
            ],
          ),

          if (profile.degreeDisplay != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.schema_rounded,
                    size: 14,
                    color: AppColors.connectionHighlightText,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    profile.degreeDisplay!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.connectionHighlightText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConnectionBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.hub_rounded,
                  size: 16,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'CONNECTION PATHWAY',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ConnectionBadge(
            connectionText: profile.connectedThrough,
            isCompact: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.format_quote_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ABOUT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            profile.about!,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.55,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    final attributes = <_AttributeItem>[
      if (profile.profession != null)
        _AttributeItem(
          icon: Icons.work_outline_rounded,
          label: 'Profession',
          value: profile.profession!,
        ),
      if (profile.education != null)
        _AttributeItem(
          icon: Icons.school_outlined,
          label: 'Education',
          value: profile.education!,
        ),
      if (profile.community != null)
        _AttributeItem(
          icon: Icons.diversity_3_outlined,
          label: 'Community',
          value: profile.community!,
        ),
      _AttributeItem(
        icon: Icons.location_city_outlined,
        label: 'City',
        value: profile.city,
      ),
      _AttributeItem(
        icon: Icons.badge_outlined,
        label: 'Profile ID',
        value: '#${profile.id}',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'ADDITIONAL DETAILS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attributes.length,
            separatorBuilder: (_, _) => const Divider(
              color: AppColors.divider,
              height: 18,
            ),
            itemBuilder: (context, index) {
              final item = attributes[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    item.icon,
                    size: 18,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 100,
                    child: Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required IconData icon,
    required String label,
    bool highlight = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: highlight
            ? AppColors.primaryLight.withValues(alpha: 0.08)
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: highlight ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
              color: highlight ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AttributeItem {
  final IconData icon;
  final String label;
  final String value;

  _AttributeItem({
    required this.icon,
    required this.label,
    required this.value,
  });
}
