import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../data/models/trail.dart';
import '../blocs/trail/trail_bloc.dart';
import '../blocs/trail/trail_state.dart';
import '../blocs/trail/trail_event.dart';

class TrailsScreen extends StatelessWidget {
  const TrailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailState>(
      builder: (context, state) {
        if (state.isLoading) {
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
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          );
        }

        final trails = state.availableTrails;
        final currentTrailId = state.currentTrail?.id;
        
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
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: trails.length,
                      itemBuilder: (context, index) {
                        final trail = trails[index];
                        final isActive = trail.id == currentTrailId;
                        return _buildTrailCard(context, trail, isActive);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Choose Your Trail',
        style: AppTypography.headlineLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTrailCard(BuildContext context, Trail trail, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: isActive 
            ? Border.all(color: Colors.white, width: 3)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 200,
          child: Stack(
            children: [
              // Background
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.8),
                      AppColors.secondary.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.landscape,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              
              // Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
              
              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trail.name,
                                  style: AppTypography.titleLarge.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  trail.location,
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (trail.isPremium)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'PREMIUM',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Row(
                        children: [
                          _buildInfoChip('${trail.totalDistance} miles'),
                          const SizedBox(width: 8),
                          _buildInfoChip(trail.difficulty),
                          const SizedBox(width: 8),
                          _buildInfoChip('~${trail.estimatedSessions} sessions'),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      if (isActive)
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Trail is already active, just show feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Currently exploring ${trail.name}'),
                                  backgroundColor: AppColors.primary,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                            ),
                            child: const Text('Continue Journey'),
                          ),
                        )
                      else
                        Container(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: trail.isPremium 
                                ? null 
                                : () {
                                    // Select this trail
                                    context.read<TrailBloc>().add(TrailSelected(trail.id));
                                    
                                    // Show confirmation and navigate back
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${trail.name} selected!'),
                                        backgroundColor: AppColors.success,
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 2),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    );
                                  },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: trail.isPremium 
                                  ? Colors.white.withValues(alpha: 0.5)
                                  : Colors.white,
                              side: BorderSide(
                                color: trail.isPremium 
                                    ? Colors.white.withValues(alpha: 0.5)
                                    : Colors.white,
                              ),
                            ),
                            child: Text(trail.isPremium ? 'Premium Required' : 'Start This Trail'),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: AppTypography.labelSmall.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}