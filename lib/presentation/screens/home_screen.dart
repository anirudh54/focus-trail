import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../data/datasources/trail_data.dart';
import '../../data/models/trail.dart';
import '../../data/models/checkpoint.dart';
import '../blocs/timer/timer_bloc.dart';
import '../blocs/timer/timer_state.dart';
import '../blocs/timer/timer_event.dart';
import '../blocs/trail/trail_bloc.dart';
import '../blocs/trail/trail_state.dart';
import '../widgets/timer_display.dart';
import '../widgets/trail_view.dart';
import '../widgets/quick_tasks.dart';
import '../widgets/timer_settings_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrailBloc, TrailState>(
      builder: (context, trailState) {
        final currentTrail = trailState.currentTrail ?? TrailData.sampleTrails.first;
        
        return BlocProvider(
          create: (context) => TimerBloc(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<TimerBloc, TimerState>(
                listenWhen: (previous, current) => 
                    previous.status != current.status && 
                    current.status == TimerStatus.completed,
                listener: (context, state) {
                  // Session completed
                },
              ),
              BlocListener<TimerBloc, TimerState>(
                listenWhen: (previous, current) => 
                    previous.recentCheckpointId != current.recentCheckpointId &&
                    current.recentCheckpointId != null,
                listener: (context, state) {
                  if (state.recentCheckpointId != null) {
                    _showCheckpointModal(context, state.recentCheckpointId!, currentTrail);
                  }
                },
              ),
            ],
            child: Scaffold(
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
                      _buildHeader(currentTrail),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildTrailSection(currentTrail),
                              _buildTimerSection(),
                              _buildControlsSection(),
                              _buildQuickTasksSection(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Trail currentTrail) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentTrail.name,
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentTrail.location,
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => _showTimerSettings(context),
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrailSection(Trail currentTrail) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: TrailView(trail: currentTrail),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const TimerDisplay(),
    );
  }

  Widget _buildControlsSection() {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildControlButton(context, state),
        );
      },
    );
  }

  Widget _buildControlButton(BuildContext context, TimerState state) {
    String buttonText;
    Color buttonColor;
    VoidCallback? onPressed;

    switch (state.status) {
      case TimerStatus.ready:
        buttonText = state.isBreakTime ? 'Start Break' : 'Start Focus';
        buttonColor = AppColors.timerReady;
        onPressed = () {
          final duration = state.isBreakTime 
              ? state.breakMinutes * 60 
              : state.focusMinutes * 60;
          context.read<TimerBloc>().add(TimerStarted(duration));
        };
        break;
      case TimerStatus.running:
        buttonText = 'Pause';
        buttonColor = AppColors.timerBreak;
        onPressed = () {
          context.read<TimerBloc>().add(TimerPaused());
        };
        break;
      case TimerStatus.paused:
        buttonText = 'Resume';
        buttonColor = AppColors.timerActive;
        onPressed = () {
          context.read<TimerBloc>().add(TimerResumed());
        };
        break;
      case TimerStatus.breakTime:
        buttonText = 'Break Time';
        buttonColor = AppColors.timerBreak;
        onPressed = null; // Break is automatic
        break;
      case TimerStatus.completed:
        buttonText = 'Session Complete!';
        buttonColor = AppColors.success;
        onPressed = () {
          context.read<TimerBloc>().add(TimerReset());
        };
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: Text(
          buttonText,
          style: AppTypography.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTasksSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Tasks',
            style: AppTypography.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const QuickTasks(),
        ],
      ),
    );
  }

  void _showTimerSettings(BuildContext context) {
    final timerBloc = context.read<TimerBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => BlocProvider.value(
        value: timerBloc,
        child: TimerSettingsSheet(
          timerBloc: timerBloc,
        ),
      ),
    );
  }

  void _showCheckpointModal(BuildContext context, String checkpointId, Trail currentTrail) {
    // Find the checkpoint from the current trail
    final checkpoint = currentTrail.checkpoints.firstWhere(
      (c) => c.id == checkpointId,
      orElse: () => currentTrail.checkpoints.first,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Checkpoint Reached!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(checkpoint.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(checkpoint.educationalFact),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Clear the checkpoint from state
              context.read<TimerBloc>().add(CheckpointModalDismissed());
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}