import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildUserSummary(),
                const SizedBox(height: 24),
                _buildAchievements(),
                const SizedBox(height: 24),
                _buildDigitalPassport(),
                const SizedBox(height: 24),
                _buildSettings(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Explorer',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Member since Nov 2024',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Trail Beginner',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Achievements',
          style: AppTypography.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildAchievementBadge('First Mile', Icons.flag, true),
              _buildAchievementBadge('Week Warrior', Icons.calendar_today, true),
              _buildAchievementBadge('10 Sessions', Icons.timelapse, true),
              _buildAchievementBadge('25 Sessions', Icons.trending_up, false),
              _buildAchievementBadge('Early Bird', Icons.wb_sunny, false),
              _buildAchievementBadge('Weekend Focus', Icons.weekend, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(String title, IconData icon, bool isUnlocked) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isUnlocked 
                ? AppColors.primary 
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isUnlocked 
                ? Colors.white 
                : Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTypography.labelSmall.copyWith(
            color: isUnlocked 
                ? Colors.white 
                : Colors.white.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDigitalPassport() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Digital Passport',
          style: AppTypography.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final stamps = [
                'Golden Gate Park',
                'Japanese Tea Garden',
                'Conservatory of Flowers',
              ];
              return _buildStamp(stamps[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStamp(String location) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_on,
            size: 32,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          Text(
            location,
            style: AppTypography.labelSmall.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: AppTypography.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildSettingsItem('Notification Settings', Icons.notifications, () {}),
              _buildSettingsDivider(),
              _buildSettingsItem('Sound & Volume', Icons.volume_up, () {}),
              _buildSettingsDivider(),
              _buildThemeToggle(),
              _buildSettingsDivider(),
              _buildSettingsItem('About Focus Trail', Icons.info, () {}),
              _buildSettingsDivider(),
              _buildSettingsItem('Rate Us', Icons.star, () {}),
              _buildSettingsDivider(),
              _buildSettingsItem('Privacy Policy', Icons.privacy_tip, () {}),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Version 1.0.0',
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: AppTypography.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.white.withOpacity(0.7),
      ),
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle() {
    return ListTile(
      leading: const Icon(
        Icons.brightness_6,
        color: Colors.white,
      ),
      title: Text(
        'Theme (Light/Dark)',
        style: AppTypography.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
      trailing: Switch(
        value: false, // This would be connected to theme state
        onChanged: (value) {
          // Handle theme toggle
        },
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildSettingsDivider() {
    return Divider(
      color: Colors.white.withOpacity(0.2),
      height: 1,
    );
  }
}