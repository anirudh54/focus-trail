import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Column(
          children: [
            // Timer status text
            Text(
              _getStatusText(state),
              style: AppTypography.titleMedium.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Main timer display
            Stack(
              alignment: Alignment.center,
              children: [
                // Progress ring
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: state.progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getTimerColor(state),
                    ),
                  ),
                ),
                
                // Timer text
                Column(
                  children: [
                    Text(
                      state.formattedTime,
                      style: AppTypography.timerDisplay.copyWith(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      state.isBreakTime ? 'Break Time' : 'Focus Time',
                      style: AppTypography.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Session counter
            if (state.completedSessions > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Sessions completed: ${state.completedSessions}',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  String _getStatusText(TimerState state) {
    switch (state.status) {
      case TimerStatus.ready:
        return state.isBreakTime ? 'Ready for break' : 'Ready to focus';
      case TimerStatus.running:
        return state.isBreakTime ? 'Break in progress' : 'Focus session active';
      case TimerStatus.paused:
        return 'Session paused';
      case TimerStatus.breakTime:
        return 'Enjoy your break!';
      case TimerStatus.completed:
        return 'Great work! Session completed';
    }
  }

  Color _getTimerColor(TimerState state) {
    switch (state.status) {
      case TimerStatus.ready:
        return AppColors.timerReady;
      case TimerStatus.running:
        return state.isBreakTime ? AppColors.timerBreak : AppColors.timerActive;
      case TimerStatus.paused:
        return AppColors.timerPaused;
      case TimerStatus.breakTime:
        return AppColors.timerBreak;
      case TimerStatus.completed:
        return AppColors.success;
    }
  }
}